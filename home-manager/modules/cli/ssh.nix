{ config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.ssh;
in
{
    options.dotfiles.home-manager.ssh = {
        enable = lib.mkEnableOption "Enable ssh module";
    };


    config = lib.mkIf cfg.enable  {
        services.ssh-agent.enable = true;

        programs.ssh = {
            enable = true;
            enableDefaultConfig = false;

            settings = {
                "github.com" = {
                    HostName = "github.com";
                    User="git";
                    IdentityFile = "~/.ssh/main";
                    AddKeysToAgent = "yes";
                };
                "*" = {
                    IdentityFile = "~/.ssh/main";
                    AddKeysToAgent = "yes";
                };
            };
        };
    };
}
