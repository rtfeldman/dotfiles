{
  packageOverrides = pkgs: {
    rustNightly = pkgs.callPackage ~/code/rust-nightly-nix {};
  };
}
