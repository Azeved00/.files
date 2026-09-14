{ pkgs, modulesPath, lib, ... }: 
{
    imports = [
        "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ];
    boot.supportedFilesystems = lib.mkForce [ 
        "btrfs" "reiserfs" "vfat" 
        "f2fs" "xfs" "ntfs" "cifs" 
    ];

    networking.hostName = "hail";

    dotfiles.nixos.xserver.enable = true;
    dotfiles.nixos.xserver.layout = "pt";
    dotfiles.nixos.tlp.enable = true;
    dotfiles.nixos.bluetooth.enable = true;


    services.xserver.xrandrHeads = [
        {
            output = "eDP-1";
            primary = true;
        }
    ];
}
