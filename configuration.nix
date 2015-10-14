{ config, pkgs, ... }:

{ imports =
    [ ./hw.nix
      ./sw/i3.nix
      ./sw/fonts.nix
      ./sw/evilvte.nix
      ./sw/dev.nix
      ./sw/desktop.nix
      ./sw/media.nix
    ];

  # virtualisation.docker.enable = true;
  # virtualisation.docker.storageDriver = "overlay";
  # virtualisation.virtualbox.guest.enable = true; # only need this *inside* a VM
  virtualisation.virtualbox.host.enable = true;

  boot = {
    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/sda";
    };
    cleanTmpDir = true;
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "1048576";
    };
  };

  networking = {
    extraHosts = "127.0.0.1 news.ycombinator.com www.reddit.com";
    networkmanager.enable = true;
    networkmanager.appendNameservers = [
      "84.200.69.80" # dns.watch servers
      "84.200.70.40"
    ];
    firewall = {
      allowPing = false;
      allowedTCPPorts = [ # incoming connections allowed
        22
        22000 # sycthing
      ];
      allowedTCPPortRanges = [];
      allowedUDPPorts = [
        21025 21026 # syncthing
      ];
      allowedUDPPortRanges = [];
      connectionTrackingModules = [];
      # extraCommands = '' cmd here '';
      # extraStopCommands = '' cmd here '';
    };
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
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
      { domain = "@audio"; type = "-"; item = "memlock"; value = "unlimited"; }
    ];
  };

  time.timeZone = "Europe/Berlin";

  services = {
    printing.enable = true;
    avahi.enable = true;

    locate = {
      enable = true;
      period = "00 */6 * * *";
      includeStore = true;
    };

    udisks2.enable = true;

    udev.extraRules = ''
      ATTRS{idVendor}=="22b8", ATTRS{idProduct}=="2e63", MODE="666", SYMLINK+="android_adb", SYMLINK+="android_fastboot"
    '';

    tor = {
      enable = true;
      client = {
        enable = true;
        socksListenAddress = "127.0.0.1:9050";
        socksListenAddressFaster = "127.0.0.1:9052";
      };
    };

    syncthing = {
      enable = true;
      user = "k";
      dataDir = "/home/k/.config/syncthing";
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
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    opengl.driSupport = true;
    opengl.driSupport32Bit = true;

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };

  users.extraUsers.k = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    extraGroups = [
     "wheel" "disk"
     "audio" "video"
     "networkmanager"
     "systemd-journal"
     "vboxusers" "docker"
    ];
    createHome = true;
    home = "/home/k";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  nixpkgs.config = {
    allowUnfree = true;
    firefox.enableAdobeFlash = true;
    firefox.enableGoogleTalkPlugin = true;
    chromium = {
      proprietaryCodecs = true;
      enablePepperFlash = true;
      enablePepperPDF = true;
      enableWideVine = true;
      enableNacl = true;
    };
    # virtualbox.enableExtensionPack = true;

    packageOverrides = pkgs: rec {
      supercollider = pkgs.supercollider.override {
        useSCEL = true;
      };

    };
  };

  nix = {
    package = pkgs.nixUnstable;
    gc.automatic = true;
    useChroot = true;
    extraOptions = ''
      binary-caches-parallel-connections = 5
    '';
  };

  programs = {
    bash = {
       promptInit = "PS1=\"# \"";
       enableCompletion = true;
    };
  };

  environment = {
    etc."hosts".mode = "0644";

    pathsToLink = [
      "/share/SuperCollider"
      "/share/recoll"
    ];

    variables = {
      NOTMUCH_CONFIG    = "$HOME/.config/notmuch/config";
      GTK_PATH          = "${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0";
      GTK_DATA_PREFIX   = "${config.system.path}";
      GIO_EXTRA_MODULES = "${pkgs.xfce.gvfs}/lib/gio/modules";
      GTK_IM_MODULE     = "xim";
      QT_IM_MODULE      = "xim";
      PATH              = "$HOME/.local/bin:$PATH";
    };
  };
}
