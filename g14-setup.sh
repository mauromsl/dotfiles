# Arch setup script for the G14 on Kernel 5.9

# Custom asus daemon
pacman -S asus-nb-ctrl-git

# Setup custom kernel should no longer be required from 5.11
cat >> /etc/pacman.conf << EOM

[g14]
SigLevel = Optional TrustAll
Server = https://arch.asus-linux.org
EOM
pacman -Sy
pacman -S linux-g14 linux-g14-headers

# Disable conflicting drivers
cat >> /etc/modprobe.d/blacklist.conf << EOM
blacklist nouveau
blacklist nvidiafb
blacklist rivafb
blacklist i2c_nvidia_gpu
EOM
