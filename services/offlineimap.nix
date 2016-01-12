{ config, pkgs, ... }:

{
  systemd.user.services.offlineimap = {
    description = "Offlineimap Daemon";

    after = [ "network.target" ];

    environment = {
      NOTMUCH_CONFIG = "/home/%u/.config/notmuch/config";
    };

    serviceConfig = {
      ExecStart = "${pkgs.offlineimap}/bin/offlineimap -u syslog";
      KillSignal = "SIGUSR2";
      Restart = "always";
    };

    wantedBy = [ "default.target" ];
  };

  systemd.services.offlineimap.enable = true;
}
