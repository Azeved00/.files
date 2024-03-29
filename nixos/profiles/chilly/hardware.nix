{ config, lib, pkgs, modulesPath, ... }:

{
    imports =[ ];

    boot = {
        initrd.availableKernelModules = [ "ohci_pci" "ehci_pci" "ahci" "sd_mod" ];
        initrd.kernelModules = [ ];
        kernelModules = [ ];
        extraModulePackages = [];

        loader.systemd-boot.enable = false;
        loader.efi.canTouchEfiVariables = true;
        loader.grub = {
            enable = true;
            device = "nodev";
        };
    };

    fileSystems."/" ={  
        device = "/dev/disk/by-uuid/f222513b-ded1-49fa-b591-20ce86a2fe7f";
        fsType = "ext4";
    };

    swapDevices = [ ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    virtualisation.virtualbox.guest.enable = true;
}
