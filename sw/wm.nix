{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefoxWrapper
    conkerorWrapper
    dmenu 
    gimp inkscape
    chromium 
    offlineimap notmuch msmtp
    evince
    xarchiver
    arandr
    trayer
    networkmanagerapplet
    gucharmap
    xdg_utils
    i3lock
    gtk 
    gnome.gnomeicontheme 
    hicolor_icon_theme
    shared_mime_info
    skype
    libnotify
    libreoffice
    gnupg pinentry

    spotify
    unrar    
    unzip

    xlibs.xev
    xsel
    xclip
    xlibs.xkill
    xlibs.xmessage
    xlibs.libX11
    xlibs.libXinerama

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
    haskellPackages.xmobar

    gtypist
    keychain

    weechat figlet
    gnupg cowsay

    aspell
    aspellDicts.en
    aspellDicts.de

    python27Full
    python27Packages.afew
    python27Packages.keyring
  ];
}
