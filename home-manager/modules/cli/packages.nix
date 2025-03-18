{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.terminal.packages;
    devapp = pkgs.writeShellApplication {
        name = "dev";
        text = builtins.readFile ./funcs/dev.sh;
    };
in
{
    options.dotfiles.home-manager.terminal.packages = {
        enable = lib.mkEnableOption "Enable terminal extra packages";
    };


    config = lib.mkIf cfg.enable  {

        home.packages = with pkgs; [ 
            tree
            btop
            zip
            unzip
            killall
            devapp
        ];

    };
}
