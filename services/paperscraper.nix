{config, pkgs, lib, ...}:

let
  cfg = config.services.paperscraper;
  krgn = import <krgn>;
in

with lib;

{
  options = {
    services.paperscraper = {
      enable = mkOption {
        default = false;
        type = with types; bool;
        description = ''
          Start the PaperScraper API service.
        '';
      };

      user = mkOption {
        default = "username";
        type = with types; uniq string;
        description = ''
          Name of the user to run as.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    jobs.paperscraper = {
      description = "Start the paperscraper service.";
      startOn = "started network-interfaces";
      exec = ''/var/setuid-wrappers/sudo -u ${cfg.user} -- ${krgn.PaperScraper}/bin/PaperScraper'';
    };

    environment.systemPackages = [ krgn.PaperScraper pkgs.recoll ];
  };
}
