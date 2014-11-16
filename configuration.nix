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
    etc."hosts".mode = "0644";

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
    kernel.sysctl = {
      "vm.swappiness" = 50;
      "fs.inotify.max_user_watches" = 524288;
    };
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

     udev.extraRules = ''
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0502", OWNER="k", GROUP="users", MODE="0666"
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0b05", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="413c", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0489", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="04c5", OWNER="k", GROUP="users", MODE="0666" 
       SUBSYSTEM=="usb", ATTRS{idVendor}=="04c5", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="091e", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="201E", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="109b", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0bb4", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="12d1", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="24e3", OWNER="k", GROUP="users", MODE="0666" 
       SUBSYSTEM=="usb", ATTRS{idVendor}=="2116", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0482", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="17ef", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="1004", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="22b8", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0e8d", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0409", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="2080", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0955", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="2257", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="10a9", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="1d4d", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0471", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="04da", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="05c6", OWNER="k", GROUP="users", MODE="0666" 
       SUBSYSTEM=="usb", ATTRS{idVendor}=="1f53", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="04e8", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="04dd", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="054c", OWNER="k", GROUP="users", MODE="0666" 
       SUBSYSTEM=="usb", ATTRS{idVendor}=="0fce", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="2340", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="0930", OWNER="k", GROUP="users", MODE="0666" 
	     SUBSYSTEM=="usb", ATTRS{idVendor}=="19d2", OWNER="k", GROUP="users", MODE="0666"
     '';


    redshift = {
      enable = true;
      brightness.day = "1.0";
      brightness.night = "0.7";
      temperature.day = 5700;
      temperature.night = 5000;
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

          eval $(keychain --eval -Q --quiet --agents gpg,ssh id_rsa fook_rsa poodle ptolemy_rsa)
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
