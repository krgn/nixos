{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc mplayer	
    audacity 
    qjackctl
    jack2
    supercollider
    supercollider_scel
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
