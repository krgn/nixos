{ config, pkgs, ... }:

{
  systemd.user.services.emacs = {
    description = "Emacs Daemon";

    environment = {
      GTK_DATA_PREFIX = config.system.path;
      GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " config.environment.profiles}"; 
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
      FSharpTargetsPath = "${pkgs.fsharp}/lib/mono/4.5/Microsoft.FSharp.Targets";
    };

    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
      ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
      Restart = "always";
    };

    wantedBy = [ "default.target" ];
  };

  systemd.services.emacs.enable = true;
}
