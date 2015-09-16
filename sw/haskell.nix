{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gmp
    pandoc

    (pkgs.haskellPackages.ghcWithPackages (self : [
      self.cabal-install
      self.stack
    ]))
  ];
}
