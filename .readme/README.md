# Dotfiles
for my ArchLinux-Systems

## Prepare
Create a user with home-directory or create one as root with

    useradd -m -U $NONROOTUSER 

enter password with

    passwd $NONROOTUSER

then as `$NONROOTUSER`

    alias dotgit="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    git clone --bare https://github.com/jumper149/dotfiles.git $HOME/.dotfiles
    dotgit config --local status.showUntrackedFiles no
    dotgit checkout

## Dependencies
ArchLinux Package dependencies for utilising the dotfiles are found in `~/.readme`:

    ~/.readme/groups
    ~/.readme/core
    ~/.readme/Maaur
    ~/.readme/maybe

To install all Packages in `groups`, `core` and `aur` call `~/.readme/install_core.sh` with

    pacsync

## Configuration by Root
Set `$NONROOTUSER` and `$NONROOTHOME` (without `'/'` at the end):

    NONROOTUSER=jumper
    NONROOTHOME=/home/jumper

### haveged
Random Number Generator

    systemctl enable haveged.service

### Networking
`wpa_supplicant` for wireless, `dhcpcd` for DHCP

    ln -s /usr/share/dhcpcd/hooks/10-wpa_supplicant /usr/lib/dhcpcd/dhcpcd-hooks/
    systemctl enable dhcpcd.service

### ca-certificates
to access eduroam-WIFI

    cp $NONROOTHOME/.readme/root-config/deutsche-telekom-root-ca-2.crt /usr/share/ca-certificates/trust-source/anchors/
    trust extract-compat /usr/share/ca-certificates/trust-source/anchors/deutsche-telekom-root-ca-2.crt

### sudo
allow sudo for group wheel with `visudo`:

    visudo
    gpasswd --add $NONROOTUSER wheel

### X
to start X

    systemctl enable sddm.service

### ufw

    systemctl enable ufw.service
    ufw default deny
    ufw limit SSH
    ufw enable

### sensors

    sensors-detect

### backlight

    gpasswd --add $NONROOTUSER video

### sshd

    systemctl enable sshd.socket

### cronie

    systemctl enable cronie.service
    gpasswd --add $NONROOTUSER users

### Bluetooth

    systemctl enable bluetooth.service

### vnstat

    systemctl enable vnstat.service
    systemctl start vnstat.service
Update the desired interfaces if necessary:

    vnstat -u -i wlp2s0
    vnstat -u -i enp0s25

### tor

    systemctl enable tor.service
maybe allow gpg keys (look into PKGBUILD when compiling snapshot)

### Mathematica
requires AUR-package and license

    systemctl enable avahi-daemon.service

## outside of home-directory

### groups

    gpasswd --add $NONROOTUSER {wheel,video,audio}

### example configurations
There are examples in `~/.readme/root-config/`.
Check these out by yourself.

    cp $NONROOTHOME/.readme/root-config/wpa_supplicant /etc/wpa_supplicant/wpa_supplicant.conf

    cp $NONROOTHOME/.readme/root-config/sshd_config /etc/ssh/sshd_config

For BIOS boot, change partition entries and maybe Kernel parameters:

    cp $NONROOTHOME/.readme/root-config/syslinux.cfg /boot/syslinux/syslinux.cfg

    cp $NONROOTHOME/.readme/root-config/sddm.conf /etc/sddm.conf

Maybe change KERNEL in `backlight.rules`:

    cp $NONROOTHOME/.readme/root-config/backlight.rules /etc/udev/rules.d/backlight.rules

udev rule for `fastermelee`:

    cp $NONROOTHOME/.readme/root-config/51-gcadapter.rules /etc/udev/rules.d/51-gcadapter.rules

## Configuration by User
Some config-files might need to be set up for your particular system:

### i3bar
Fill in some necessary information:

    ~/.system-info.sh
Check everything in `$HOME/.config/i3blocks`, especially:

    temperature.sh
    fan.sh
    battery.sh


### blugon

    systemctl --user enable blugon.service

### mpd

    systemctl --user enable mpd.service

### trash
Set up `$HOME/.trash` for ranger:

    mkdir ~/.trash

### pass
Copy your `.password-store` to `$HOME/.password-store`:

    cp .password-store $HOME/.password-store
Have an entry `test/test` with password `test` inside or create it with

    pass insert test/test
Copy everything necessary into `$HOME/.gnupg`.

### cronie
Overwrite the empty crontab for your user:

    crontab ~/.readme/root-config/crontab

### pacsync

    mkdir ~/Packages
    git clone https://github.com/jumper149/pkgaur.git ~/Packages/pkgaur

## Additional Information

Places that use hardcoded color configuration:

    ~/.Xresources
    ~/.vimrc @ colorscheme
    ~/.config/blugon/config
    ~/.config/rofi/jumper-i3.rasi
    ~/.config/zathura/zathurarc
    ~/.config/i3blocks/scripts/battery.sh
    ~/.config/i3blocks/scripts/cpu.sh
    ~/.config/i3blocks/scripts/traffic.sh
    ~/.config/i3blocks/scripts/volume.sh
some more, but depending on `~/.Xresources`:

    ~/.config/i3/config
    ~/.mutt/colors
    ~./irssi/default.theme
    ~/.config/neofetch/config.conf
    ~/.config/ranger/rc.conf @ colorscheme
    ~/.scripts/tty-colors.sh
    ~/.bashrc @ prompt
    ~/.zshrc @ prompt
