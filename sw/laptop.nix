{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  programs.light.enable = true;

  services.xserver.synaptics = {
    enable = true;
    vertEdgeScroll = false;
    tapButtons = false;
    twoFingerScroll = true;
    accelFactor = "1";
    buttonsMap = [ 1 3 2 ];
    palmDetect = true; 
    additionalOptions = ''
      Option "VertScrollDelta" "-18"
      Option "HorizScrollDelta" "18"
      Option "CoastingFriction" "10"
      Option "CoastingSpeed"    "50"
    '';
  };
}
