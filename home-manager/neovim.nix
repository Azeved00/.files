{ config, pkgs, lib, ...}:
{
home.activation.installNvimConfig = ''
    if [ -d "${config.home.homeDirectory}/.config/nvim" ]; then
        rm ${config.home.homeDirectory}/.config/nvim
    fi
    ln -s "${config.home.homeDirectory}/.files/Config/nvim" "${config.home.homeDirectory}/.config/nvim"
'';


programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
};
}
