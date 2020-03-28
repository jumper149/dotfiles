{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-atool";
    paths = [
      pkgs.atool
      pkgs.cpio
      pkgs.gnutar
      pkgs.gzip
      pkgs.bzip2 # not parallel
      pkgs.lzip # not parallel
      pkgs.lzma
      pkgs.lzop
      pkgs.lhasa # works with atool?
      pkgs.p7zip
      #pkgs.unarj # not free
      #pkgs.unrar # not free
      pkgs.unzip
      # missing?: unace, rpm, arc, nomarch, unalz
    ];
  }
