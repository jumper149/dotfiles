self: super: {

  myDependencies = {
    aspell-configured = super.aspellWithDicts (d: with d; [en de]);
  };

  pythonLatestPackages = super.python39Packages;

    #### #### #### #### #### #### #### #### #### #### #### #### #### #### #### ####

  userPackages = {

    # nix-channels <nixpkgs> and <nixos> need to be set up
    nix-rebuild = super.writeScriptBin "nix-rebuild" ''
      #!${super.stdenv.shell}
      set -e
      if [ "$1" = "--upgrade" ]; then
        nix-channel --update nixpkgs
      fi
      nix-env -f '<nixpkgs>' -r -iA userPackagesUnstable "$@"
    '';

  };

}
