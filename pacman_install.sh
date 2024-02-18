#! /bin/bash
echo "Installing Packages"
sudo pacman -R --noconfirm \
	vim

sudo pacman -Sy --noconfirm \
	i3-wm \
	i3status \
	i3lock \
	i3-gaps \
	dunst \
	rofi \
	nitrogen \
	gvim \
	git \
	strace \
	bash-completion \
	terminator \
	docker \
	docker-compose \
	openssh \
	pulseaudio-jack \
	flameshot \
	peek \
	playerctl \
	acpilight \
	blueman \
	arandr \
	autorandr \
	xsel \
	gimp \
	firefox

