{ config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.i3;
in
{

    config = lib.mkIf cfg.enable  {

        home.packages = with pkgs; [ 
            xclip
        ];

    };
}
