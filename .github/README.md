# Dotfiles
for my ArchLinux-Systems

## Prepare
Prepare a user with a home-directory:

    NONROOTUSER=jumper

Set `$NONROOTHOME` without `'/'` at the end:

    NONROOTHOME=/home/jumper

Clone this repository as `$NONROOTUSER`:

    alias dotgit="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
    git clone --bare https://github.com/jumper149/dotfiles.git $HOME/.dotfiles
    dotgit config --local status.showUntrackedFiles no
    dotgit checkout

## Configuration by Root

### keyboard
Install custom keymap.

    mkdir -p /usr/local/share/kbd/keymaps
    cp $NONROOTHOME/.readme/root-config/jumper.map.gz /usr/local/share/kbd/keymaps/
    localectl set-keymap --no-convert /usr/local/share/kbd/keymaps/jumper-us.map

### networking

    ln -s /usr/share/dhcpcd/hooks/10-wpa_supplicant /usr/lib/dhcpcd/dhcpcd-hooks/
Use ca-certificate to access eduroam-WIFI: `$NONROOTHOME/.readme/root-config/T-TeleSec_GlobalRoot_Class_2.pem`

### sudo
Allow sudo for group `wheel` with `visudo`:

    visudo

### ufw

    ufw default deny
    ufw limit SSH
    ufw enable

### sensors

    sensors-detect

### bluetooth headset
Add the user to the `lp` group (accessing printers etc.) to access pulseaudio, if it is running as root.

    gpasswd --add $NONROOTUSER lp
Add this to `/etc/pulse/default.pa` to enable A2DP:

    # LDAC Standard Quality
    #load-module module-bluetooth-discover a2dp_config="ldac_eqmid=sq"

    # LDAC High Quality; Force LDAC/PA PCM sample format as Float32LE
    load-module module-bluetooth-discover a2dp_config="ldac_eqmid=hq ldac_fmt=f32"

### vnstat (old, for i3)
Update the desired interfaces if necessary:

    vnstat -u -i wlp2s0
    vnstat -u -i enp0s25

## outside of home-directory

### groups

    gpasswd --add $NONROOTUSER {users,wheel,video,audio}

### example configuration files
There are some examples in `~/.readme/root-config/`.
Check these out by yourself.

## Configuration by User

### safegit
Set up repository for private files:

    git clone --bare git@github.com:jumper149/dotsafe.git $HOME/.dotsafe
    safegit config --local status.showUntrackedFiles no
    safegit checkout

### pass
Copy your `.password-store` to `$HOME/.password-store`:

    cp .password-store $HOME/.password-store
Have an entry `test/test` with password `test` inside or create it with

    pass insert test/test
Copy everything necessary into `$HOME/.gnupg`.

### trash
Set up `$HOME/.trash` for ranger:

    mkdir ~/.trash

### hoogle
Create offline hoogle database:

    hoogle generate

### i3bar (old, for i3)
Fill in some necessary information in `~/.system-info.sh`.
Check everything in `$HOME/.config/i3blocks`, especially:

    temperature.sh
    fan.sh
    battery.sh

## Additional Information

Places that use hardcoded color configuration:

    ~/.Xresources
    ~/.vimrc @ colorscheme
    ~/.vim/colors/wombat256jumper.vim
    ~/.config/blugon/config
    ~/.config/rofi/jumper-i3.rasi
    ~/.config/zathura/zathurarc
    ~/.config/i3blocks/scripts/battery.sh
    ~/.config/i3blocks/scripts/cpu.sh
    ~/.config/i3blocks/scripts/traffic.sh
    ~/.config/i3blocks/scripts/volume.sh
    ~/.config/sway/config
    ~/.xmonad/xmonad.hs
    ~/.xmobarrc
    ~/.xmobar/icons/
some more, but depending on `~/.Xresources`:

    ~/.config/i3/config
    ~/.mutt/colors
    ~./irssi/default.theme
    ~/.config/neofetch/config.conf
    ~/.config/ranger/rc.conf @ colorscheme
    ~/.scripts/tty-colors.sh
    ~/.bashrc @ prompt
    ~/.zshrc @ prompt
