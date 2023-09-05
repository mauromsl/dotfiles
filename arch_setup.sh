#! /bin/bash
echo "Installing Packages"
sudo pacman -R --noconfirm\
	vim

sudo pacman -Sy --noconfirm\
	i3-gaps \
	py3status \
	git \
	strace \
	bash-completion \
	terminator \
	pulseaudio-jack \
	docker \
	docker-compose \
	openssh \
	gvim \
	playerctl \
	firefox \
	flameshot \
	peek


echo "Configuring docker"
sudo usermod -aG docker $USER
sudo systemctl enable docker && systemctl start docker

sudo systemctl enable sshd && systemctl start sshd

echo "Configuring bash"
rm $HOME/.bashrc || true 2>/dev/null
rm $HOME/.bash_profile || true  2>/dev/null
rm $HOME/.my-bashrc || true  2>/dev/null
rm $HOME/.profile || true 2>/dev/null

ln -s `pwd`/.bashrc $HOME/.bashrc
ln -s `pwd`/.profile $HOME/.profile
ln -s `pwd`/.my-bashrc $HOME/.my-bashrc
ln -s `pwd`/.bash_profile $HOME/.bash_profile

echo "Configuring Vim"
rm $HOME/.vimrc || true 2>/dev/null
ln -s `pwd`/.vimrc $HOME/.vimrc

[[ ! -f $HOME/.vim/bundle/Vundle.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


echo "Configuring i3"

rm -rf $HOME/.config/i3 || true 2>/dev/null
ln -s `pwd`/i3-config $HOME/.config/i3

echo "Configuring Terminator"

rm -rf $HOME/.config/terminator || true 2>/dev/null
ln -s `pwd`/terminator-config $HOME/.config/terminator

echo "Configuring Git"
rm -rf $HOME/.gitconfig || true 2>/dev/null
ln -s `pwd`/.gitconfig $HOME/.gitconfig

echo "Configuring X"
rm -rf $HOME/.xprofile || true 2>/dev/null
ln -s `pwd`/.xprofile $HOME/.xprofile
rm -rf $HOME/.Xresources || true 2>/dev/null
ln -s `pwd`/Xresources $HOME/.Xresources
systemctl --user enable redshift-gtk.service

rm -rf $HOME/.git-prompt.sh || true 2>/dev/null
ln -s `pwd`/git-prompt.sh $HOME/.git-prompt.sh

echo "Configuring GTK themes"
rm -rf $HOME/.themes || true 2>/dev/null
ln -s `pwd`/themes $HOME/.themes
rm -rf $HOME/.config/gtk-3.0 || true 2>/dev/null
ln -s `pwd`/gtk-3.0 s$HOME/.config/gtk-3.0

echo "Configuring nitrogen"
rm -rf $HOME/.config/nitrogen || true 2>/dev/null
ln -s `pwd`/nitrogen $HOME/.config/nitrogen
rm -rf $HOME/.config/assets || true 2>/dev/null
ln -s `pwd`/assets $HOME/.config/assets


echo "Configuring mimeapps"
rm $HOME/.config/.mimeapps.list ||: 2>/dev/null
ln -s `pwd`/.mimeapps.list $HOME/.config/.mimeapps.list
