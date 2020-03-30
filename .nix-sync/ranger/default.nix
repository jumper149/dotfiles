{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-ranger";
    paths = [
      pkgs.ranger
      #pkgs.atool                     # already installed
      pkgs.ffmpegthumbnailer
      pkgs.highlight
      pkgs.imagemagick
      pkgs.jq
      pkgs.mediainfo
      pkgs.python37Packages.pdftotext
      #pkgs.w3m                       # already installed
      # not in nixpkgs: djvutxt, epub-thumbnailer, od2txt, fontimage
    ];
  }
