#! /bin/bash
echo "Installing Packages"
sudo pacman -R --noconfirm \
	vim

sudo pacman -Sy --noconfirm \
	i3-wm \
	i3status \
	i3lock \
	i3-gaps \
    xcompmgr \
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
    ruff \
	openssh \
    pipewire-pulse \
	flameshot \
	peek \
	playerctl \
	acpilight \
	blueman \
    gotop \
	arandr \
	autorandr \
	xsel \
	gimp \
    transmission-cli \
    ranger \
    picom \
    fastcompmgr \
    clipit \
    # equalizer \
    easyeffects \
    easyeffects-presets \
    calf \
    lsp-plugins \
    zam-plugins \
	firefox

