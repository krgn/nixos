{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    keepassx2
    gimp inkscape
    chromium
    offlineimap notmuch 
    evince
    xarchiver
    arandr
    trayer
    networkmanagerapplet
    gucharmap
    xdg_utils
    gtk 
    shared_mime_info
    skype
    spotify
    libnotify
    libreoffice
    gnupg pinentry
    msmtp
    unrar    
    unzip
    multimarkdown
    scrot
    xlibs.xev
    xsel
    xclip
    xlibs.xkill
    xlibs.xmessage
    xlibs.libX11
    xlibs.libXinerama

    xfce.ristretto
    xfce.gtk_xfce_engine
    xfce.gvfs 
    xfce.thunar 
    xfce.thunar_volman 
    xfce.tumbler
    xfce.xfce4icontheme
    tango-icon-theme
    gnome3.adwaita-icon-theme  

    gtypist
    keychain

    figlet cowsay

    pythonPackages.afew
  ];
}
