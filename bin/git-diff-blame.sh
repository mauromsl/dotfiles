#!/usr/bin/perl -w
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.

sub parse_hunk_header {
	my ($line) = @_;
	my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
	    $line =~ /^@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@/;
	$o_cnt = 1 unless defined $o_cnt;
	$n_cnt = 1 unless defined $n_cnt;
	return ($o_ofs, $o_cnt, $n_ofs, $n_cnt);
}

sub get_blame_prefix {
	my ($line) = @_;
	$line =~ /^(\^?[0-9a-f]+\s+(\S+\s+)?\([^\)]+\))/ or die "bad blame output: $line";
	return $1;
}

$git_root = `git rev-parse --show-toplevel`;
$git_root =~ s/^\s+//;
$git_root =~ s/\s+$//;
chdir($git_root) or die "$!";

my ($oldrev, $newrev) = @ARGV;
$oldrev ||= 'HEAD';
if ($newrev) {
	open($diff, '-|', 'git', '--no-pager', 'diff', $oldrev, $newrev) or die;
} else {
	open($diff, '-|', 'git', '--no-pager', 'diff', $oldrev) or die;
}

my ($pre, $post);
my $filename;
while (<$diff>) {
	if (m{^diff --git ./(.*) ./\1$}) {
		close $pre if defined $pre;
		close $post if defined $post;
		print;
		$prefilename = "./" . $1;
		$postfilename = "./" . $1;
		$delete = $create = 0;
	} elsif (m{^new file}) {
		$create = 1;
		$prefilename = '/dev/null';
	} elsif (m{^deleted file}) {
		$delete = 1;
		$postfilename = '/dev/null';
	} elsif (m{^--- $prefilename$}) {
		# ignore
		print;
	} elsif (m{^\+\+\+ $postfilename$}) {
		# ignore
		print;
	} elsif (m{^@@ }) {
		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt)
			= parse_hunk_header($_);
		my $o_end = $o_ofs + $o_cnt - 1;
		my $n_end = $n_ofs + $n_cnt - 1;
		if (!$create) {
			open($pre, '-|', 'git', 'blame', '-M', "-L$o_ofs,$o_end",
			     $oldrev, '--', $prefilename) or die;
		}
		if (!$delete) {
			if ($newrev) {
				open($post, '-|', 'git', 'blame', '-M', "-L$n_ofs,$n_end",
				     $newrev, '--', $postfilename) or die;
			} else {
				open($post, '-|', 'git', 'blame', '-M', "-L$n_ofs,$n_end",
				     '--', $postfilename) or die;
			}
		}
	} elsif (m{^ }) {
		print "    ", get_blame_prefix(scalar <$pre>), "\t", $_;
		scalar <$post>; # discard
	} elsif (m{^\-}) {
		print "␛[31m -  ", get_blame_prefix(scalar <$pre>), "\t", $_,"␛[m";
	} elsif (m{^\+}) {
		print "␛[32m +  ", get_blame_prefix(scalar <$post>), "\t", $_,"␛[m";
	}
}

