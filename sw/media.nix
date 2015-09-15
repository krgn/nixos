{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc mplayer
    audacity
    qjackctl
    jack2Full
    ardour

    pavucontrol
    ladspaPlugins
    calf
    puredata

    handbrake
    supercollider

    libdvdcss
    libdvdnav
    libdvdread

    alsaLib
    alsaUtils
    alsaPlugins
  ];
}
