{config, lib, ...}:
let
    cfg = config.dotfiles.home-manager.desktop.xdg;
in
{
    options.dotfiles.home-manager.desktop.xdg = {
        enable = lib.mkEnableOption "Enable xdg stuff (default apps and dirs)";
    };

    config = lib.mkIf cfg.enable {
        xdg = {
            enable = true;

            mimeApps = {
                enable = true;
                associations.added = {
                    "application/pdf"   =  ["org.pwmt.zathura.desktop"];

                    "text/plain"        =  ["nvim.desktop"];
                    "text/rust"         =  ["nvim.desktop"];
                    "text/markdown"     =  ["nvim.desktop"];
                    "application/toml"  =  ["nvim.desktop"];
                };
                associations.removed= {
                    "application/pdf"   =  ["krita_pdf.desktop"];
                };
                defaultApplications = {
                    "application/pdf"   =  ["org.pwmt.zathura.desktop"];

                    "text/plain"        =  ["nvim.desktop"];
                    "text/rust"         =  ["nvim.desktop"];
                    "text/markdown"     =  ["nvim.desktop"];
                    "application/toml"  =  ["nvim.desktop"];
                };
            };

            userDirs = {
                enable = true;
                createDirectories = false;
            };
        };
    };
}
