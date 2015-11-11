      exec = ''/var/setuid-wrappers/sudo -u ${cfg.user} -- ${pkgs.paperscraper}/bin/PaperScraper'';
    };

    environment.systemPackages = [ pkgs.paperscraper ];
  };
}
