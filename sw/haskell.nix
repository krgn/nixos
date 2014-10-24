{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gmp

    (pkgs.haskellPackages.ghcWithPackages (self : [
      self.ghcMod 
      self.hint
      self.hoogle
      self.happy
      self.alex
      self.cabalInstall
      self.cabal2nix
      self.cabal2Ghci

      self.xmonad
      self.xmonadContrib
      self.xmonadExtras
    ]))
  ];
}
