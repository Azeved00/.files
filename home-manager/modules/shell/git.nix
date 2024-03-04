{config, lib, ...}:
let 
    cfg = config.dotfiles.home-manager.git;
in
{

    options.dotfiles.home-manager.git = {
        enable = lib.mkEnableOption "Enable git module";
    };

    config = lib.mkIf cfg.enable {
        programs.git = {
            enable = true;
            userName  = "João Azevedo";
            userEmail = "62391524+Azeved00@users.noreply.github.com";

            aliases = {
                s = "status";
                c = "commit -m";
                d = "difftool";
                a = "add";
            };

            extraConfig = {
                advice = {
                    addIgnoredFile = false;
                };
                fetch = {
                    prune = true;
                };
                diff = {
                    colorMoved = "zebra";
                };
                core =  {
                    editor = "nvim";
                    autocrlf = false;
                };
                init = {
                    defaultBranch = "main";
                };
                pull = {
                    rebase = false;
                };
                push = {
                    autoSetupRemote = true;
                };
                diff.tool = "vimdiff";
                difftool.prompt = false;

            };
        };
    };
}
