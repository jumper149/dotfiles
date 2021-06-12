let

  fallbackPackages = [
  ];

  unstablePackages = let
    XPackages = [
    ];
    CLIPackages = [
      "amfora"
      "atool"
      "dict"
      "dig"
      "elinks"
      "file"
      "fzf"
      "git"
      "gnupg"
      "htop"
      "killall"
      "ranger"
      "sc-im"
      "sshfs"
      "tmux"
      "traceroute"
      "vim"
      "vimpager"
      "xdg-user-dirs"
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
