{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-firefox";
    paths = [
      pkgs.firefox
      pkgs.passff-host
    ];
  }
