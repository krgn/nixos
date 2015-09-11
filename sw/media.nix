{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc mplayer	
    audacity 
    qjackctl
    jack2Full
    ardour
    supercollider
    pavucontrol
    ladspaPlugins
    calf
    puredata

    handbrake

    libdvdcss
    libdvdnav
    libdvdread

    alsaLib
    alsaUtils
    alsaPlugins 
  ];
}

