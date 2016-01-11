# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../sw/laptop.nix
  ];

  boot.loader.grub.device = "/dev/sda";
  boot.initrd.luks.devices = [
    { name = "peng"; device = "/dev/sda3"; preLVM = true; allowDiscards = true; }
  ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" ];
  boot.blacklistedKernelModules = [ "nouveau" "snd_pcsp" "pcspkr" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.kernelPackages = pkgs.linuxPackages // {
    virtualbox = pkgs.linuxPackages.virtualbox.override {
      # enableExtensionPack = true;
      pulseSupport = true;
    };
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/cf18c7cd-d6aa-4b5c-8a31-f48c7d83a2fb";
      fsType = "ext4";
      options = "noatime,nodiratime,discard";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/d9806c02-33bf-494b-8e89-1e0085d5ee43";
      fsType = "ext4";
      options = "noatime,nodiratime,discard";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/da0b6289-59b2-464c-bd07-21643700bfe1";
      fsType = "ext2";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/f2ece8a2-48fc-454e-b8cb-d2d094b7179f"; }
    ];

  networking.hostName = "peng";

  services.xserver.xkbOptions = "compose:ralt,ctrl:swapcaps";

  nix.maxJobs = 4;
}
