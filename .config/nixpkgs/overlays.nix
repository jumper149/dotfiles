let

  fallbackPackages = [
  ];

  unstablePackages = let
    XPackages = [
  ];
    CLIPackages = [
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
    "ranger"
    "sshfs"
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
