{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gmp

    (pkgs.haskellPackages.ghcWithPackages (self : [
      self.cabal-install
      self.stack
    ]))
  ];
}
