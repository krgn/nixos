{ config, pkgs, ... }:

{
  imports = [
    ./sw/wm.nix
    ./sw/media.nix
    ./sw/dev.nix
    ./sw/haskell.nix
  ];
}
