{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs24PackagesNg.hydra
  ];
}
