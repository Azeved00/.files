{ config, pkgs, lib, ...}:
{
    programs.ssh = {
        enable = true;

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
}
