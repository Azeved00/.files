{ config, pkgs, lib, ...}:
{
home.activation.installNvimConfig = ''
    if [ -d "${config.xdg.configHome}/nvim" ]; then
        rm ${config.xdg.configHome}/nvim
    fi
    ln -s "${config.home.homeDirectory}/.files/Config/nvim" "${config.xdg.configHome}/nvim"
'';


programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
};
}
