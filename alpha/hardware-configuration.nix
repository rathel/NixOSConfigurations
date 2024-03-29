# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
# Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  hardware.pulseaudio.enable = false;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/adfb0d8c-da1e-46f7-87a4-d580074a38c5";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9267-B0BE";
      fsType = "vfat";
    };

   fileSystems."/home" = 
    { device = "/dev/disk/by-uuid/7c8f7ff8-d3d7-4e6a-b5f3-40d8a6d53fcd";
      fsType = "ext4";
    };

   fileSystems."/home/rathel/Downloads" = {
     device = "172.23.147.210:/home/rathel/Downloads";
     fsType = "nfs";
     options = [ "x-systemd.automount" "noauto" ];
   };
   
   fileSystems."/home/rathel/Applications" = {
     device = "172.23.147.210:/srv/Applications";
     fsType = "nfs";
     options = [ "x-systemd.automount" "noauto" ];
   };

  swapDevices = [ 
  { device = "/dev/disk/by-uuid/c2fd42cf-e1fd-4708-9c51-4f4d09ecea8e"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20u3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}


