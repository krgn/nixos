{ config, pkgs, ... }:

let myStuff = import ./derivations;

in {

  imports =
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
    };
    cleanTmpDir = true;
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
      enable = true;
      allowPing = false;
      allowedTCPPorts = [ # incoming connections allowed
        22
        9418
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
    # consoleFont = "Lat2-Terminus16";
    consoleFont = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
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

      extraConfig = ''
        HiddenServiceDir /var/lib/tor/services/ssh # needs to have 700perms
        HiddenServicePort 22 127.0.0.1:22
      '';

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
    firmware = [
      pkgs.firmwareLinuxNonfree
      myStuff.brcmFirmware
    ];

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
     "lp" "kmem"
     "wheel" "disk"
     "audio" "video"
     "networkmanager"
     "systemd-journal"
     "vboxusers" "docker"
     "utmp" "adm" "input"
     "tty" "floppy" "uucp"
     "cdrom" "tape" "dialout"
    ];
    createHome = true;
    home = "/home/k";
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      proprietaryCodecs = true;
      enablePepperFlash = true;
      enablePepperPDF = true;
      enableWideVine = true;
      enableNacl = true;
    };
    # virtualbox.enableExtensionPack = true;

    packageOverrides = super: let self = super.pkgs; in rec {
      supercollider = super.supercollider.override {
        useSCEL = true;
      };

      i3status = pkgs.stdenv.lib.overrideDerivation super.i3status (oldAttrs: {
        patches = [
          ./patches/0001-add-support-for-reading-files.patch
        ];
      });

      linux_4_3 = super.linux_4_3.override {
        kernelPatches = super.linux_4_3.kernelPatches ++ [
          # we'll add the Ubuntu Fan Networking patches from Nixpkgs
          # self.kernelPatches.ubuntu_fan
          # and we'll also add one of our own patches
          { patch = ./patches/0001-brcmfmac-Add-support-for-the-BCM4350-PCIE-device.patch; name = "4350-support"; }
        ];
      };
    };
  };

  nix = {
    package = pkgs.nixStable;
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

    etc."X11/Xresources".text = ''
      Xcursor.theme: adwaita

      Xft.dpi: 192
      Xft.autohint: 0
      Xft.lcdfilter:  lcddefault
      Xft.hintstyle:  hintfull
      Xft.hinting: 1
      Xft.antialias: 1
      Xft.rgba: rgb
    '';

    pathsToLink = [
      "/share/SuperCollider"
      "/share/recoll"
      "/include"
    ];

    variables = {
      NOTMUCH_CONFIG    = "$HOME/.config/notmuch/config";
      GTK_PATH          = "${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0";
      GTK_DATA_PREFIX   = "${config.system.path}";
      GIO_EXTRA_MODULES = "${pkgs.xfce.gvfs}/lib/gio/modules";
      GTK_IM_MODULE     = "xim";
      QT_IM_MODULE      = "xim";
      PATH              = "$HOME/.local/bin:$PATH";

      QT_DEVICE_PIXEL_RATIO = "2";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";

      FSharpTargetsPath = "${pkgs.fsharp}/lib/mono/4.5/Microsoft.FSharp.Targets";
    };
  };
}
