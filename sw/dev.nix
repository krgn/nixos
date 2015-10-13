{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arp-scan
    aspell
    aspellDicts.de
    aspellDicts.en
    atop
    autoconf
    automake
    androidsdk_4_4
    android-udev-rules
    clang
    cmake
    coreutils
    ctags
    curl
    darcs
    dmidecode
    docker
    docker
    emacs
    ettercap
    file
    fish
    fsharp
    gcc
    gdb
    gforth
    gitFull
    gitAndTools.git-annex
    gnumake
    gparted
    htop
    iftop
    iotop
    llvm
    lshw
    lsof
    meld
    mercurial
    mono
    monodevelop
    mosh
    mr
    nix-prefetch-scripts
    nmap
    nodePackages.npm
    nodejs
    pandoc
    powertop
    psmisc
    python
    ranger
    ruby
    silver-searcher
    smartmontools
    subversion
    tcpdump
    telnet
    tmux
    tree
    usbutils
    vcsh
    vim
    wget
    which
    wireshark
    exfat
  ];
}
