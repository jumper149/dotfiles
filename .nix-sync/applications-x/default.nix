{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-applications-x";
    paths = with pkgs; [
      arandr
      baobab
      blugon
      conky
      gimp
      i3lock
      # kitty
      # libreoffice
      pavucontrol
      rofi
      scrot
      sxiv
      tdesktop
      xdotool
      xmobar
      zathura
      # zoom-us

      # chromium
      rxvt-unicode
    ];
  }
