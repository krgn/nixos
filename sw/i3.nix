{ config, pkgs, ... }:

{
  environment.etc = {
    "i3status.conf" = {
    text = ''
    # i3status configuration file.
    # see "man i3status" for documentation.

    # It is important that this file is edited as UTF-8.
    # The following line should contain a sharp s:
    # ß
    # If the above line is not correctly displayed, fix your editor first!

    general {
            colors = true
            interval = 5
    }

    order += "ipv6"
    order += "disk /"
    order += "run_watch DHCP"
    order += "run_watch VPN"
    order += "wireless _first_"
    order += "ethernet _first_"
    order += "battery 0"
    order += "load"
    order += "tztime local"

    wireless _first_ {
            format_up = "W: (%quality at %essid) %ip"
            format_down = "W: down"
    }

    ethernet _first_ {
            # if you use %speed, i3status requires root privileges
            format_up = "E: %ip (%speed)"
            format_down = "E: down"
    }

    battery 0 {
            format = "%status %percentage %remaining"
    }

    run_watch DHCP {
            pidfile = "/var/run/dhclient*.pid"
    }

    run_watch VPN {
            pidfile = "/var/run/vpnc/pid"
    }

    tztime local {
            format = "%Y-%m-%d %H:%M:%S"
    }

    load {
            format = "%1min"
    }

    disk "/" {
            format = "%avail"
    }
    '';
    };
  };

  environment.systemPackages = with pkgs; [
    i3
    i3lock
    i3status
    dmenu
    xsel
    xclip
    dunst
    libnotify
    networkmanagerapplet
  ];

  programs.ssh.startAgent = false;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    startGnuPGAgent = true;

    displayManager = {
      auto.enable = true;
      auto.user = "k";
      sessionCommands = with pkgs; ''
        xrdb -merge /etc/X11/Xresources
        xrdb -merge ~/.Xresources
        ${i3}/bin/i3
      '';
      desktopManagerHandlesLidAndPower = false;
    };

    desktopManager.xterm.enable = false;
  };
}
