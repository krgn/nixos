{ config, pkgs, ... }:

{
  services.xserver.synaptics = {
    enable = true;
    vertEdgeScroll = false;
    tapButtons = false;
    twoFingerScroll = true;
    accelFactor = "0.001";
    buttonsMap = [ 1 3 2 ];
    additionalOptions = ''
      Option "VertScrollDelta" "-18"
      Option "HorizScrollDelta" "18"
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
