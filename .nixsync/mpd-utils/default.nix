{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-mpd-utils";
    paths = [
      pkgs.mpc_cli
      pkgs.ncmpcpp
    ];
  }
