{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vlc mplayer
    audacity
    qjackctl
    jack2Full
    ardour

    ffmpeg
    gst_ffmpeg
    gst_plugins_bad
    gst_plugins_base
    gst_plugins_good
    gst_plugins_ugly
 
    pavucontrol
    ladspaPlugins
    calf
    puredata

    # handbrake
    supercollider

    libdvdcss
    libdvdnav
    libdvdread

    alsaLib
    alsaUtils
    alsaPlugins
  ];
}
