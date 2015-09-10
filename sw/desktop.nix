{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    keepass
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
    gnome.gnomeicontheme 
    hicolor_icon_theme
    shared_mime_info
    skype
    spotify
    libnotify
    libreoffice
    gnupg pinentry
    msmtp
    unrar    
    unzip

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

    gtypist
    keychain

    figlet cowsay

    pythonPackages.afew
  ];
}
