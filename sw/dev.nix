{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget curl
    vcsh mr
    vim emacs
    monodevelop
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

    meld
    man_db
    which
    tree
    file
    clang
    llvm
    gcc
    cmake
    gnumake
    autoconf
    automake
    coreutils
  
    inetutils
    arp-scan 
    wireshark
    tcpdump
    ettercap
    nmap
    telnet
    bind

    gparted
    smartmontools
    dmidecode

    # emacs24Packages.cask
    ctags
    nix-prefetch-scripts

    ruby python
    
    nodejs
    nodePackages.npm

    gdb
    gforth
    mono
    fsharp

    docker 

    aspell
    aspellDicts.en
    aspellDicts.de
  ];
}
