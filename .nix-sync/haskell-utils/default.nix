{ pkgs , ... }:
  pkgs.symlinkJoin {
    name = "my-haskell-utils";
    paths = [
      pkgs.cabal-install
      pkgs.cabal2nix
      pkgs.ghc
      pkgs.haskellPackages.hoogle
    ];
  }
