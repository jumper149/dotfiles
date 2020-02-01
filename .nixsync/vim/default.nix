{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-vim";
    paths = [
      pkgs.vimHugeX
      pkgs.vimPlugins.supertab
      pkgs.vimPlugins.vim-airline
      pkgs.vimPlugins.vim-airline-themes
      pkgs.vimPlugins.wombat256-vim
    ];
  }
