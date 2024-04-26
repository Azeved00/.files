{ config, lib, pkgs,...}:
let 
    cfg = config.dotfiles.home-manager.neofetch;
in
{
    options.dotfiles.home-manager.neofetch = {
        enable = lib.mkEnableOption "Enable neofetch module";
    };


    config = lib.mkIf cfg.enable  {
        xdg.configFile."neofetch_config" = {
            enable = true;
            executable = true;
            text = builtins.readFile ./config.conf;
            target = "neofetch/config.conf";
        };
        xdg.configFile."neofetch_image" = {
            enable = true;
            executable = true;
            text = builtins.readFile ./image;
            target = "neofetch/image";
        };
        home.packages = with pkgs; [ neofetch];
    };
}
