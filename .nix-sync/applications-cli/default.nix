{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-applications-cli";
    paths = with pkgs; [
      git
      htop
      killall
      mpv
      offlineimap
      openconnect
      pass
      # texlive-combined-basic
      tmux
      vimpager-latest
      youtube-dl
    ];
  }
