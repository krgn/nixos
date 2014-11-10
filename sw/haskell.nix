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
      self.purescript
      
      self.xmonad
      self.xmobar
      self.taffybar
      self.xmonadContrib
      self.xmonadExtras
    ]))
  ];
}
