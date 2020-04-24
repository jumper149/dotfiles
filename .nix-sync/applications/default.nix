{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-applications";
    paths = [
      arandr
      baobab
      blugon
      # chromium
      conky
      gimp
      git
      htop
      i3lock
      killall
      libreoffice
      mpv
      offlineimap
      openconnect
      pass
      pavucontrol
      rofi
      # rxvt-unicode-with-perl-with-unicode3-with-plugins-9.22
      scrot
      sxiv
      tdesktop
      # texlive-combined-basic
      vimpager-latest
      xdotool
      xmobar
      youtube-dl
      zathura-with-plugins
      zoom-us
    ];
  }
