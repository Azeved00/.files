{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.desktop.i3;
in
{

    config = lib.mkIf cfg.enable  {

        home.packages = with pkgs; [ 
            xclip
        ];

    };
}
