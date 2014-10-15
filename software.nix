{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget curl
    vcsh mr
    vim emacs
    htop iotop powertop
    firefox firefoxWrapper
    dmenu tmux
    gimp inkscape
    git subversion
    weechat figlet
    chromium 
    fish
    offlineimap notmuch msmtp
    vlc mplayer	
    audacity 
    evince
    xarchiver
    ranger
    arandr
    silver-searcher
    xlibs.xmessage
    psmisc
    trayer
    networkmanagerapplet
    gucharmap
    xdg_utils
    i3lock
    gnupg
    gtk 
    gnome.gnomeicontheme 
    hicolor_icon_theme
    shared_mime_info
    skype
    libnotify
    libreoffice
    docker

    # msf
    # arp-scan 
    # wireshark
    # kismet
    # tcpdump
    # ettercap

    xsel
    xclip
    xlibs.xkill
    xfce.terminal
    xfce.ristretto
    xfce.gtk_xfce_engine
    xfce.gvfs 
    xfce.thunar 
    xfce.thunar_volman 
    xfce.tumbler
    xfce.xfce4icontheme
    xfce.xfce4settings
    xfce.xfce4notifyd
    xfce.xfconf

    emacs24Packages.cask

    gnome3.gnome_keyring
    gnome3.seahorse

    aspell
    aspellDicts.en
    aspellDicts.de

    python27Full
    python27Packages.afew
    python27Packages.keyring

    ghc.ghc783
    haskellPackages.xmobar
    haskellPackages.xmonad
    haskellPackages.xmonadContrib
    haskellPackages.xmonadExtras
  ];
}
