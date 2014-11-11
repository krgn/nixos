{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gmp

    (pkgs.haskellPackages.ghcWithPackages (self : [
      self.cabalInstall
      self.xmonad
      self.xmobar
      self.xmonadContrib
      self.xmonadExtras
    ]))
  ];
}
