{ config, lib,...}:
let 
    cfg = config.dotfiles.home-manager.fastfetch;
in
{
    options.dotfiles.home-manager.fastfetch = {
        enable = lib.mkEnableOption "Enable fastfetch module";
    };


    config = lib.mkIf cfg.enable  {
        programs.fastfetch = {
            enable = true;
            settings = builtins.fromJSON (builtins.readFile ./config.jsonc);
        };
        xdg.configFile."fastfetch_image" = {
            enable = true;
            executable = true;
            text = builtins.readFile ./image.txt;
            target = "fastfetch/image.txt";
        };
    };
}
