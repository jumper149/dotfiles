{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-theme";
    paths = [
      pkgs.bibata-cursors
    ];
  }
