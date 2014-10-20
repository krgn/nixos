{ config, pkgs, ... }:

{
  imports = [
    ./sw/wm.nix
    ./sw/audio.nix
    ./sw/dev.nix
    ./sw/haskell.nix
  ];
}
