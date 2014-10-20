{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget curl
    vcsh mr
    vim emacs
    atop htop iotop powertop
    tmux
    git subversion
    fish
    ranger
    silver-searcher
    psmisc
    docker
    couchdb
    postgresql94

    tree
    file
    clang
    llvm
    gcc
    cmake
    gnumake
    autoconf
    automake
  
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
