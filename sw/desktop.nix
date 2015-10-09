{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arandr
    chromium
    cowsay
    evince
    figlet 
    firefox-wrapper
    geeqie
    gimp 
    gnome3.adwaita-icon-theme  
    gnome3.cheese 
    gnome3.gnome-video-effects
    gnupg 
    gtk 
    gtypist
    gucharmap
    inkscape
    kde4.calligra 
    keepassx2
    keychain
    libnotify
    libreoffice
    msmtp
    multimarkdown
    networkmanagerapplet
    notmuch 
    offlineimap 
    pamixer
    pinentry
    poppler_utils
    pythonPackages.afew
    recoll
    perlPackages.ImageExifTool
    antiword
    scrot
    shared_mime_info
    skype
    spotify
    tango-icon-theme
    tesseract
    tetex
    trayer
    unrar    
    unzip
    xarchiver
    xclip
    xdg_utils
    xfce.gtk_xfce_engine
    xfce.gvfs 
    xfce.ristretto
    xfce.thunar 
    xfce.thunar_volman 
    xfce.tumbler
    xfce.xfce4icontheme
    xfce.xfconf
    xlibs.libX11
    xlibs.libXinerama
    xlibs.xev
    xlibs.xkill
    xlibs.xmessage
    xsel
    xss-lock
  ];
}
