{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./hardware.nix
    ./software.nix
    <nixos/modules/programs/virtualbox.nix>
  ];

  time.timeZone = "Europe/Berlin";

  virtualisation.docker.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableAdobeFlash = true;
    firefox.enableGoogleTalkPlugin = true;
    chromium.enablePepperFlash = true;
    chromium.enablePepperPDF = true;

    packageOverrides = pkgs: rec {
      emacs = pkgs.emacs.override { librsvg = pkgs.librsvg; };
    };

    virtualbox.enableExtensionPack = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    gc.automatic = true;
    useChroot = true;
    extraOptions = ''
      binary-caches-parallel-connections = 200
    '';
  };

  environment = {
    loginShellInit = ''
      case "$TERM" in
         "dumb")
             PS1="> "
             ;;
         xterm*|rxvt*|eterm*|screen*)
             ;;
         *)
             PS1="> "
             ;;
      esac
    '';

    interactiveShellInit = ''
      case "$TERM" in
         "dumb")
             PS1="> "
             ;;
         xterm*|rxvt*|eterm*|screen*)
             ;;
         *)
             PS1="> "
             ;;
      esac
    '';

    shellInit = ''
      export LD_LIBRARY_PATH=/lib64:$LD_LIBRARY_PATH
      export GTK_PATH=${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0
      export GTK_DATA_PREFIX=${config.system.path}
      export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules

      case "$TERM" in
         "dumb")
             PS1="> "
             ;;
         xterm*|rxvt*|eterm*|screen*)
             ;;
         *)
             PS1="> "
             ;;
      esac
    '';

    pathsToLink = [ 
      "/share/xfce4"
      "/share/themes" 
      "/share/mime" 
      "/share/desktop-directories"
    ];
  };

  boot = { 
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.device = "/dev/sda";
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
  };

  networking = { 
    networkmanager.enable = true;
    networkmanager.appendNameservers = [
      "8.8.8.8" "8.8.4.4" 
    ];
  };

  i18n = {
    consoleFont   = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudio.override {
      jackaudioSupport = true;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false; 
    };
    pam.loginLimits = [
      { domain = "@audio"; type = "-"; item = "rtprio"; value = "99"; } 
      { domain = "@audio"; type = "-"; item = "memlock"; value = "500000"; } 
    ];
  };

  programs.ssh.startAgent = false;

  services = {
    printing.enable = true;
    bitlbee.enable = true;

    nixosManual.showManual = true;
    avahi.enable = true;
    locate.enable = true;

    redshift = {
      enable = true;
      brightness.day = "1.0";
      brightness.night = "0.7";
      temperature.day = 5500;
      temperature.night = 4500;
      latitude = "52.51";
      longitude = "13.4";
    };

    openssh = {
      enable = true;
      forwardX11 = false;
      permitRootLogin = "no";
      passwordAuthentication = false;
      extraConfig = ''
        AllowAgentForwarding yes
      ''; 
    };

    xserver = {
      enable = true;
      autorun = true;
      layout = "us";

      startGnuPGAgent = false;
      desktopManager.xterm.enable = false;
      desktopManager.default      = "none";

      displayManager = {
        auto.enable = true;    
        auto.user = "k";
        desktopManagerHandlesLidAndPower = false;
        sessionCommands = ''
          source $HOME/.profile
          # important for $HOME/.XCompose to work
          export GTK_IM_MODULE=xim
          export QT_IM_MODULE=xim

          eval $(keychain --eval -Q --quiet id_rsa)
          exec feh --bg-center $HOME/pics/comet.jpg &
          exec xsetroot -solid black &
          exec nm-applet &
          exec xfsettingsd &
        '';
      };

      windowManager = {
          default = "xmonad";
          xmonad = {
            enable = true;
            enableContribAndExtras = true;
        };
      };
    };    
  };

  systemd.services.i3lock = {
    description = "start i3lock after resume and powerup";
    before = [ "sleep.target" ];
    after = [ "graphical.target" ];
    wantedBy = [ "graphical.target" "suspend.target" ]; 
    serviceConfig = {
      User = "k";
      Type = "forking";
      Environment = "DISPLAY=:0";
      ExecStart = "/run/current-system/sw/bin/i3lock -c #000000";
    };
  };

  users.extraUsers.k = {
    name = "k";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/k";
    extraGroups = [ 
      "wheel" "kmem"
      "vboxusers" "docker"
      "messagebus" "disk"
      "audio" "floppy" 
      "uucp" "lp" "cdrom"
      "tape" "video" "dialout"
      "utmp" "adm" "networkmanager"
      "systemd-journal" "keys"
    ];
    shell = "/run/current-system/sw/bin/bash";
  };
}
