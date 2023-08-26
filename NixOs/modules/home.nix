{pkgs, ...}:
{
    home-manager.useGlobalPkgs = true;  
    home-manager.users.azevedo = { pkgs, ... }: {
        home.stateVersion = "23.05";
        home.packages = [ pkgs.atool pkgs.httpie ];
        programs.bash.enable = true;


        programs.git = {
            enable = true;
            userName  = "João Azevedo";
            userEmail = "62391524+Azeved00@users.noreply.github.com";

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
            };
        };
   };
}
