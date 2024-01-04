#! /bin/bash
echo "Configuring docker"
sudo usermod -aG docker $USER
sudo systemctl enable docker && systemctl start docker

sudo systemctl enable sshd && systemctl start sshd

echo "Configuring bash"
rm $HOME/.bashrc || true 2>/dev/null
rm $HOME/.bash_profile || true  2>/dev/null
rm $HOME/.my-bashrc || true  2>/dev/null
rm $HOME/.profile || true 2>/dev/null
rm -r $HOME/.local/bin || true 2>/dev/null

ln -s `pwd`/.bashrc $HOME/.bashrc
ln -s `pwd`/.profile $HOME/.profile
ln -s `pwd`/.my-bashrc $HOME/.my-bashrc
ln -s `pwd`/.bash_profile $HOME/.bash_profile
ln -s `pwd`/bin/ $HOME/.local/bin


echo "Configuring Vim"
rm $HOME/.vimrc || true 2>/dev/null
ln -s `pwd`/.vimrc $HOME/.vimrc


echo "Configuring i3"
rm -rf $HOME/.config/i3 || true 2>/dev/null
ln -s `pwd`/i3-config $HOME/.config/i3

echo "Configuring Terminator"
rm -rf $HOME/.config/terminator || true 2>/dev/null
ln -s `pwd`/terminator-config $HOME/.config/terminator

echo "Configuring custom scripts"
rm -rf $HOME/.local/bin || true 2>/dev/null
ln -s `pwd`/bin $HOME/.local/bin

echo "Configuring Git"
rm -rf $HOME/.gitconfig || true 2>/dev/null
ln -s `pwd`/.gitconfig $HOME/.gitconfig

echo "Configuring X"
rm -rf $HOME/.xprofile || true 2>/dev/null
ln -s `pwd`/.xprofile $HOME/.xprofile
rm -rf $HOME/.Xresources || true 2>/dev/null
ln -s `pwd`/Xresources $HOME/.Xresources

rm -rf $HOME/.git-prompt.sh || true 2>/dev/null
ln -s `pwd`/git-prompt.sh $HOME/.git-prompt.sh

echo "Configuring GTK themes"
rm -rf $HOME/.themes || true 2>/dev/null
ln -s `pwd`/themes $HOME/.themes
rm -rf $HOME/.config/gtk-3.0 || true 2>/dev/null
ln -s `pwd`/gtk-3.0 $HOME/.config/gtk-3.0

echo "Configuring nitrogen"
rm -rf $HOME/.config/nitrogen || true 2>/dev/null
ln -s `pwd`/nitrogen $HOME/.config/nitrogen
rm -rf $HOME/.local/share/backgrounds || true 2>/dev/null
ln -s `pwd`/share/backgrounds $HOME/.local/share/backgrounds


echo "Configuring mimeapps"
rm $HOME/.config/.mimeapps.list || 2>/dev/null
ln -s `pwd`/.mimeapps.list $HOME/.config/.mimeapps.list
