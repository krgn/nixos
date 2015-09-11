{ config, pkgs, ... }:

{ imports =
    [ ./hw.nix
      ./sw/i3.nix
      ./sw/fonts.nix
      ./sw/evilvte.nix
      ./sw/dev.nix
      ./sw/desktop.nix
      ./sw/media.nix
      ./sw/systemd.nix
    ];

  virtualisation.docker.enable = true;
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

  programs.ssh.startAgent = false;

  time.timeZone = "Europe/Berlin";

  services = {
    printing.enable = true;
    avahi.enable = true;
    locate.enable = true;
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

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
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
    chromium.enablePepperFlash = true;
    chromium.enablePepperPDF = true;
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

 programs.bash.promptInit = "PS1=\"# \"";

 environment = {
    etc."hosts".mode = "0644";

    variables.DBUS_SESSION_BUS_ADDRESS = "/run/user/${builtins.toString config.users.extraUsers.k.uid}/dbus/user_bus_socket";
    variables.GTK_PATH = "${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0";
    variables.GTK_DATA_PREFIX = "${config.system.path}";
    variables.GIO_EXTRA_MODULES = "${pkgs.xfce.gvfs}/lib/gio/modules";
    variables.GTK_IM_MODULE = "xim";
    variables.QT_IM_MODULE = "xim";

    pathsToLink = [
      "/share/xfce4"
      "/share/themes"
      "/share/mime"
      "/share/desktop-directories"
    ];
  };
}
