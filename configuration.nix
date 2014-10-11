{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./software-configuration.nix
  ];

  time.timeZone = "Europe/Berlin";

  nixpkgs = { 
    config.allowUnfree = true;
    config.firefox.enableAdobeFlash = true;
    config.chromium.enableAdobeFlash = true;
  };

  nix = {
    gc.automatic = true;
    useChroot = true;
  };

  environment = {
    shellInit = ''
	# Set GTK_PATH so that GTK+ can find the Xfce theme engine.
        export GTK_PATH=${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0
	# Set GTK_DATA_PREFIX so that GTK+ can find the Xfce themes.
        export GTK_DATA_PREFIX=${config.system.path}
	# Set GIO_EXTRA_MODULES so that gvfs works.
        export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules
	# Launch xfce settings daemon.
        xfsettingsd &
    '';
    pathsToLink =
      [ "/share/xfce4" "/share/themes" "/share/mime" "/share/desktop-directories"];
  };

  boot = { 
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.device = "/dev/sda";
    initrd.luks.devices = [ { name = "luksroot"; device = "/dev/sda3"; preLVM = true; } ];
    blacklistedKernelModules = [ "snd_pcsp" "pcspkr" ];
  };

  networking = { 
    hostName = "nanook";
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

  hardware.pulseaudio.enable = true;

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

  services = {
    #printing.enable = true;
    bitlbee.enable = true;

    gnome3.gnome-keyring.enable = true;
    nixosManual.showManual = true;
    avahi.enable = true;
    locate.enable = true;

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
      xkbOptions = "ctrl:swapcaps,compose:ralt";
      desktopManager.xterm.enable = false;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
      synaptics = {
        enable = true;
        vertEdgeScroll = false;
        tapButtons = false;
        twoFingerScroll = true;
        additionalOptions = ''
          Option "VertScrollDelta" "-18"
          Option "HorizScrollDelta" "-18"
        '';
      };
      displayManager.auto.enable = true;
      displayManager.auto.user = "k";
      displayManager.desktopManagerHandlesLidAndPower = false;
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
      "messagebus" "disk"
      "audio" "floppy" 
      "uucp" "lp" "cdrom"
      "tape" "video" "dialout"
      "utmp" "adm" "networkmanager"
      "systemd-journal" "keys"
    ];
    shell = "/run/current-system/sw/bin/bash";
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      ubuntu_font_family
      source-code-pro  
      cantarell_fonts
      dejavu_fonts
      dosemu_fonts 
      xlibs.fontadobe100dpi
      xlibs.fontadobe75dpi
      xlibs.fontadobeutopia100dpi
      xlibs.fontadobeutopia75dpi
      xlibs.fontadobeutopiatype1
      xlibs.fontalias
      xlibs.fontarabicmisc
      xlibs.fontbh100dpi
      xlibs.fontbh75dpi
      xlibs.fontbhlucidatypewriter100dpi
      xlibs.fontbhlucidatypewriter75dpi
      xlibs.fontbhttf
      xlibs.fontbhtype1
      xlibs.fontbitstream100dpi
      xlibs.fontbitstream75dpi
      xlibs.fontbitstreamtype1
      xlibs.fontcronyxcyrillic
      xlibs.fontcursormisc
      xlibs.fontdaewoomisc
      xlibs.fontdecmisc
      xlibs.fontibmtype1
      xlibs.fontisasmisc
      xlibs.fontjismisc
      xlibs.fontmicromisc
      xlibs.fontmisccyrillic
      xlibs.fontmiscethiopic
      xlibs.fontmiscmeltho
      xlibs.fontmiscmisc
      xlibs.fontmuttmisc
      xlibs.fontschumachermisc
      xlibs.fontscreencyrillic
      xlibs.fontsonymisc
      xlibs.fontsunmisc
      xlibs.fontutil
      xlibs.fontwinitzkicyrillic
      xlibs.fontxfree86type1
      ttf_bitstream_vera
      freefont_ttf
      ipafont
      liberation_ttf
      lohit-fonts
      proggyfonts
      terminus_font
      ttmkfdir
      ubuntu_font_family
      vistafonts
      ucsFonts
      xfontsel
      xlsfonts
    ];
  };
}
