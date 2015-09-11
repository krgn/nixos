{ config, pkgs, ... }:

{
  hardware.bluetooth.enable = true;

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

  systemd.services = {
    i3lock = {
      description = "start i3lock after resume and powerup";
      before = [ "sleep.target" ];
      after = [ "dbus.target" ];
      wantedBy = [ "graphical.target" "suspend.target" ];
      serviceConfig = {
        User = "k";
        Type = "forking";
        Environment = "DISPLAY=:0";
        ExecStart = "/run/current-system/sw/bin/i3lock -c #000000";
      };
    };
  };
}
