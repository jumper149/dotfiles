{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-ranger";
    paths = [
      pkgs.ranger
      #pkgs.atool                     # already installed
      pkgs.highlight
      pkgs.ffmpegthumbnailer
      pkgs.imagemagick
      #pkgs.w3m                       # already installed
      pkgs.python37Packages.pdftotext
    ];
  }
