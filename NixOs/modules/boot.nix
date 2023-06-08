{ config, ... }:
{

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.device = "nodev";
    boot.extraModulePackages = [config.boot.kernelPackages.rtl88x2bu ];

}
