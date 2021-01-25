let

  fallbackPackages = [
    "chromium"
    "firefox"
    "libreoffice"
    "qutebrowser"
  ];

  unstablePackages = [
    "alacritty"
    "arandr"
    "atool"
    "baobab"
    "bind"
    "blucontrol"
    #"chromium"
    "conky"
    "dict"
    "dig"
    "elinks"
    "file"
    #"firefox"
    "flashrom"
    "fzf"
    "gimp"
    "git"
    "glava"
    "gnupg"
    "haskell-utils"
    "htop"
    "i3lock"
    "khal"
    "khard"
    "killall"
    "kitty"
    #"libreoffice"
    "mpc"
    "mpv"
    "mumble"
    "mutt"
    "ncmpcpp"
    "offlineimap"
    "openconnect"
    "pass"
    "pavucontrol"
    "pinentry"
    #"qutebrowser"
    "ranger"
    "rofi"
    "rxvt-unicode"
    "screenkey"
    "scrot"
    "sshfs"
    "sxiv"
    "telegram"
    #"texlive"
    "theme"
    "tmux"
    "traceroute"
    "vim"
    "vimpager"
    "weechat"
    "xdg-user-dirs"
    "xdotool"
    "xmobar"
    "youtube-dl"
    "zathura"
    #"zoom-us"
  ];

  overlay-base = import ./overlays-custom/base.nix;
  overlay-main = import ./overlays-custom/main.nix;
  overlay-fallback = (import ./overlays-custom/fallback.nix) fallbackPackages;
  overlay-unstable = (import ./overlays-custom/unstable.nix) unstablePackages fallbackPackages;

in [
  overlay-base
  overlay-main
  overlay-fallback
  overlay-unstable
]
