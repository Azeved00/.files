{config,lib,...}:
let 
    cfg = config.dotfiles.home-manager.desktop;
in
{
    imports =  [
        ./eww-bar
        ./i3

        ./dunst.nix
        ./gtk.nix
        ./rofi.nix
        ./xdg.nix
    ];

    options.dotfiles.home-manager.desktop = {
        enable = lib.mkEnableOption "Enable the full desktop";
    };

    config = lib.mkIf cfg.enable {
        dotfiles.home-manager.desktop = {
            eww.enable = lib.mkDefault true;
            i3.enable = lib.mkDefault true;

            dunst.enable = lib.mkDefault true;
            gtk.enable = lib.mkDefault false;
            rofi.enable = lib.mkDefault true;
            xdg.enable = lib.mkDefault true;
        };
    };
}
