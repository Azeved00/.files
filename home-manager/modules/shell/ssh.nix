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
            AddKeysToAdgent = "yes";

            matchBlocks = {
                "github.com" = {
                    hostname = "github.com";
                    user="git";
                    identityFile = "~/.ssh/main";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };

                "second" = {
                    hostname = "github.com";
                    user = "git";
                    identityFile="~/.ssh/second";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };

                "gitlab" = {
                    hostname = "gitedu.alunos.dcc.fc.up.pt";
                    user = "git";
                    identityFile="~/.ssh/gitlab";
                    extraOptions={
                        AddKeysToAgent = "yes";
                    };
                };
            };
        };
    };
}
