{pkgs, lib, config, ...}:
let
    cfg = config.dotfiles.nixos.gui ;
    cli-pkgs = with pkgs; [
        gcc
        wget
        git
        home-manager
        neovim
        lf
    ];
    gui-pkgs =  with pkgs; [
        appimage-run
        steam-run
        i3
        networkmanagerapplet
        pavucontrol
        zathura
        alacritty
    ];
in
with lib;
{
    imports = [];

    options.dotfiles.nixos.gui = mkEnableOption "Add Gui Package";

    config ={
        environment.systemPackages =
            cli-pkgs ++ lib.optionals cfg gui-pkgs;
    };
}
