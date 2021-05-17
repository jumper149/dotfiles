let

  fallbackPackages = [
    "chromium"
    "libreoffice"
    "telegram"
  ];

  unstablePackages = let
    XPackages = [
      "alacritty"
      "arandr"
      "baobab"
      "blucontrol"
      #"chromium"
      "conky"
      "element"
      "firefox"
      "gimp"
      "glava"
      "i3lock"
      "kitty"
      #"libreoffice"
      "mpv"
      "mumble"
      "pavucontrol"
      "pdfpc"
      "pinentry" # TODO: is this necessary for CLI?
      "qutebrowser"
      "rofi"
      "rxvt-unicode"
      "screenkey"
      "scrot"
      "sxiv"
      #"telegram"
      "theme"
      "xdotool"
      "xournal"
      "xmobar"
      "zathura"
      #"zoom-us"
    ];
    CLIPackages = [
      "amfora"
      "atool"
      #"bind" # TODO: remove?
      "dict"
      "dig"
      "elinks"
      "file"
      "flashrom"
      "fzf"
      "git"
      "gnupg"
      "haskell-utils"
      "htop"
      "khal"
      "khard"
      "killall"
      "mpc"
      "mutt"
      "ncmpcpp"
      "offlineimap"
      "openconnect"
      "pass"
      "pulsemixer"
      "ranger"
      "sc-im"
      "sshfs"
      "task"
      #"texlive"
      "tmux"
      "traceroute"
      "vim"
      "vimpager"
      "weechat"
      "xdg-user-dirs"
      "youtube-dl"
    ];
  in CLIPackages ++ XPackages;

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
