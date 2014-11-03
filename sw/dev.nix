{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget curl
    vcsh mr
    vim emacs
    atop htop iotop iftop powertop
    tmux
    lsof
    lshw
    mosh
    gitFull subversion mercurial darcs
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
    inetutils
    arp-scan 
    wireshark
    kismet
    tcpdump
    ettercap
    nmap
    telnet

    gparted
    smartmontools
    dmidecode

    emacs24Packages.cask
    ctags
    nix-prefetch-scripts

    ruby_2_1_2
    rubyLibs.bundler
    
    nodejs
    nodePackages.npm
    nodePackages.npm2nix

    gdb
    gforth
    mono
    fsharp

    aspell
    aspellDicts.en
    aspellDicts.de
  ];
}
