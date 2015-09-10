{ config, pkgs, ... }:

{
  # systemd.user.services = {

  #   i3lock = {
  #     description = "start i3lock after resume and powerup";
  #     before = [ "sleep.target" ];
  #     after = [ "dbus.target" ];
  #     wantedBy = [ "graphical.target" "suspend.target" ]; 
  #     serviceConfig = {
  #       User = "k";
  #       Type = "forking";
  #       Environment = "DISPLAY=:0";
  #       ExecStart = "/run/current-system/sw/bin/i3lock -c #000000";
  #     };
  #   };

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
  #   };

  #   emacs = {
  #     description = "Emacs Daemon";
  #     environment.GTK_DATA_PREFIX = config.system.path;
  #     environment.SSH_AUTH_SOCK = "%t/ssh-agent";
  #     environment.GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
  #     environment.NOTMUCH_CONFIG = "/home/%u/.config/notmuch/config";
  #     serviceConfig = {
  #       Type = "forking";
  #       ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
  #       ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
  #       Restart = "always";
  #     };
  #     wantedBy = [ "default.target" ];
  #   };
  # };

  # systemd.user.services.emacs.enable = true;
}
