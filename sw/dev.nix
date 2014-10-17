{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget curl
    vcsh mr
    vim emacs
    htop iotop powertop
    tmux
    git subversion
    fish
    ranger
    silver-searcher
    psmisc
    docker
    couchdb
    postgresql94

    # msf
    arp-scan 
    wireshark
    kismet
    tcpdump
    ettercap

    emacs24Packages.cask
    
    aspell
    aspellDicts.en
    aspellDicts.de
  ];
}
