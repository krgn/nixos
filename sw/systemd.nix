{ config, pkgs, ... }:

{
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

  #   dunst = {
  #     description = "start dunst notification daemon";
  #     after = [ "graphical.target" ];
  #     wantedBy = [ "graphical.target" ]; 
  #     serviceConfig = {
  #       User = "k";
  #       Environment = "DISPLAY=:0";
  #       ExecStart = "/run/current-system/sw/bin/dunst";
  #       Restart = "always";
  #     };
}
