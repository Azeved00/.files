{ config, pkgs, lib, ...}:
{
xdg.enable = true;
xdg.configFile."nvim" =  {
	enable = true;
	recursive = false;
	source = ../Config/nvim;
	target = "nvim";
};

programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
};
}
