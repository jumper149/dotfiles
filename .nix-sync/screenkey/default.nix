{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-screenkey";
    paths = [
      pkgs.screenkey
      pkgs.inconsolata
    ];
  }
