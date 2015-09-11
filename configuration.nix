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

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # virtualisation.virtualbox.guest.enable = true; # only need this *inside* a VM
  virtualisation.virtualbox.host.enable = true;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.cleanTmpDir = true;
  boot.blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "1048576";
  };

  networking = {
    extraHosts = "127.0.0.1 news.ycombinator.com www.reddit.com";
    networkmanager.enable = true;
    networkmanager.appendNameservers = [
      "8.8.8.8" "8.8.4.4"
    ];
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
      { domain = "@audio"; type = "-"; item = "memlock"; value = "500000"; }
    ];
  };

  time.timeZone = "Europe/Berlin";

  services = {
    printing.enable = true;
    avahi.enable = true;

    locate.enable = true;
    locate.period = "00 12 * * *";

    udisks2.enable = true;

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
    #virtualbox.enableExtensionPack = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    gc.automatic = true;
    useChroot = true;
    extraOptions = ''
      binary-caches-parallel-connections = 5
    '';
  };

 programs.bash = {
    promptInit = "PS1=\"# \"";
    enableCompletion = true;
 };

 environment = {
    etc."hosts".mode = "0644";

    profileRelativeEnvVars = {
      MANPATH = [ "/man" "/share/man" ];
    };

    variables = { 
      NOTMUCH_CONFIG = "${config.users.extraUsers.k.home}/.config/notmuch/config";
      GTK_PATH = "${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0";
      GTK_DATA_PREFIX = "${config.system.path}";
      GIO_EXTRA_MODULES = "${pkgs.xfce.gvfs}/lib/gio/modules";
      GTK_IM_MODULE = "xim";
      QT_IM_MODULE = "xim";
    };

    pathsToLink = [
      "/share/xfce4"
      "/share/themes"
      "/share/mime"
      "/share/desktop-directories"
    ];
  };
}
