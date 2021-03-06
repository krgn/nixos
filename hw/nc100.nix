# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, pkgs, ... }:

{
  imports = [
     <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../sw/laptop.nix
  ];

  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "usb_storage" ];
  boot.initrd.luks.devices = [ 
    { name = "pvol1"; device = "/dev/sda3"; preLVM = true; }  
  ];
  boot.kernelModules = [ "aes" "sha1" "sha256" "xts" ];
  boot.blacklistedKernelModules = [ "nouveau" "snd_pcsp" "pcspkr" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/nanook-root";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/mapper/nanook-home";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/sda2";
      fsType = "ext2";
    };

  swapDevices =
    [ { device = "/dev/mapper/nanook-swap"; }
    ];

  nix.maxJobs = 2;

  networking.hostName = "nanook";
}
