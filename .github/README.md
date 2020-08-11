# Dotfiles
for my ArchLinux-Systems

## Prepare
Prepare a user with a home-directory:

    NONROOTUSER="jumper"

Clone this repository as `$NONROOTUSER`:

    alias dotgit='git --git-dir="${HOME}/.dotfiles/" --work-tree="${HOME}"'
    git clone --bare https://github.com/jumper149/dotfiles.git "${HOME}/.dotfiles"
    dotgit config --local status.showUntrackedFiles no
    dotgit checkout

## Configuration by Root

Set `$NONROOTHOME` without `'/'` at the end:

    NONROOTHOME="/home/${NONROOTUSER}"

### keyboard
Install custom keymap.

    mkdir -p "/usr/local/share/kbd/keymaps"
    cp "${NONROOTHOME}/.github/misc/jumper.map.gz" "/usr/local/share/kbd/keymaps/"
    localectl set-keymap --no-convert /usr/local/share/kbd/keymaps/jumper-us.map

### sensors

    sensors-detect

### vnstat (old, for i3)
Update the desired interfaces if necessary:

    vnstat -u -i wlp2s0
    vnstat -u -i enp0s25

### groups

    gpasswd --add "${NONROOTUSER}" {users,wheel,video,audio}

### example configuration files
There are some examples in `~/.github/misc/`.
Check these out by yourself.

## Configuration by User

### safegit
Set up repository for private files:

    git clone --bare git@github.com:jumper149/dotsafe.git "${HOME}/.dotsafe"
    safegit config --local status.showUntrackedFiles no
    safegit checkout

### pass
Copy your `.password-store` to `$HOME/.password-store`:

    cp .password-store "${HOME}/.password-store"
Have an entry `test/test` with password `test` inside or create it with

    pass insert test/test
Copy everything necessary into `$HOME/.gnupg`.

### i3bar (old, for i3)
Fill in some necessary information in `~/.system-info.sh`.
Check everything in `$HOME/.config/i3blocks`, especially:

    temperature.sh
    fan.sh
    battery.sh

## Additional Information

Places that use hardcoded color configuration:

    ~/.Xresources
    ~/.vim/colors/wombat256jumper.vim
    ~/.config/alacritty/alacritty.yml
    ~/.config/kitty/kitty.conf
    ~/.config/qutebrowser/config.py
    ~/.config/rofi/theme.rasi
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
    ~/.bashrc @ prompt
    ~/.zshrc @ prompt

## ArchLinux
ArchLinux Package dependencies can be found here:

    ~/.pac/groups
    ~/.pac/core
    ~/.pac/aur
    ~/.pac/maybe
Install `groups` manually:

    sudo pacman -S $(< ~/.pac/groups | tr '\n' ' ')
To install all Packages in `core` and `aur` call `~/.scripts/pacsync.sh`:
    pacsync
