{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-mutt";
    paths = [
      pkgs.abook
      pkgs.enscript
      pkgs.mutt
      pkgs.msmtp
      pkgs.sxiv
      pkgs.urlscan
      pkgs.w3m
      pkgs.zathura
    ];
  }
