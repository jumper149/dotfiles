# Dotfiles
for my NixOS-Systems

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

### groups

    gpasswd --add "${NONROOTUSER}" {users,wheel,video,audio}

### example configuration files
There are some examples in `~/.github/misc/`.
Check these out by yourself.

## Configuration by User

### nix package management
Add main `'<nixpkgs>'` and fallback `'<nixos>'` channel:

    nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
    nix-channel --add https://nixos.org/channels/nixos-20.09 nixos

Use the nix-rebuild script to fetch the packages:

    nix-enx -iA userPackages "nix-rebuild"
    nix-rebuild --upgrade

### safegit
Set up repository for private files:

    git clone --bare git@github.com:jumper149/dotsafe.git "${HOME}/.dotsafe"
    safegit config --local status.showUntrackedFiles no
    safegit checkout

### pass
Set up repository for passwords:

    git clone git@github.com:jumper149/password-store.git "${HOME}/.password-store"

## Keys
Import GPG keys:

    gpg import example.key
    gpg import example.secretkey

Copy SSH keys:

    cp example.pub "${HOME}/.ssh"
    cp example.secretkey "${HOME}/.ssh"

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
