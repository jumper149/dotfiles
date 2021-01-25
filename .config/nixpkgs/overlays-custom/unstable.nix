unstablePackages: fallbackPackages: self: super: {

  userPackagesUnstable = super.lib.getAttrs (["nix-rebuild"] ++ unstablePackages) (removeAttrs super.userPackages fallbackPackages);

}
