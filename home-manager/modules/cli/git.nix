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

            settings = {
                user.name  = "João Azevedo";
                user.email = "62391524+Azeved00@users.noreply.github.com";
                aliases = {
                    s = "status";
                    c = "commit -m";
                    d = "difftool";
                    a = "add";
                };
                advice = {
                    addIgnoredFile = false;
                };
                fetch = {
                    prune = true;
                    writeCommitGraph = true;
                };
                diff = {
                    colorMoved = "zebra";
                };
                core =  {
                    editor = "nvim";
                    autocrlf = false;
                    untrackedcache = true;
                    fsmonitor = true;
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
                column.ui = "auto";
                branch.sort = "-commiterdate";

            };
        };
    };
}
