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

            dataFile."mime/packages/drawio.xml"= {
                enable = true;
                onChange = "update-mime-database ~/.local/share/mime";
                text = ''
                    <?xml version="1.0" encoding="utf-8"?>
                    <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
                    <mime-type type="application/vnd.jgraph.mxfile">
                      <glob pattern="*.drawio"/>
                        <comment>draw.io Diagram</comment>
                      <icon name="x-office-document" />
                    </mime-type>
                    <mime-type type="application/vnd.visio">
                      <glob pattern="*.vsdx"/>
                        <comment>VSDX Document</comment>
                      <icon name="x-office-document" />
                    </mime-type>
                    </mime-info>
                '';
            };

            mimeApps = {
                enable = true;
                associations.added = {
                    "application/pdf"   =  ["org.pwmt.zathura.desktop"];

                    "text/plain"        =  ["nvim.desktop"];
                    "text/rust"         =  ["nvim.desktop"];
                    "text/markdown"     =  ["nvim.desktop"];
                    "application/toml"  =  ["nvim.desktop"];
                    "application/drawio" = [ "drawio.desktop" ];
                };
                associations.removed= {
                    "application/pdf"   =  ["krita_pdf.desktop"];
                };
                defaultApplications = {
                    # 📄 Text and Code Files
                    "text/plain"        = ["nvim.desktop"];
                    "text/rust"         = ["nvim.desktop"];
                    "text/markdown"     = ["nvim.desktop"];
                    "application/toml"  = ["nvim.desktop"];
                    "application/json"  = ["nvim.desktop"];
                    "application/xml"   = ["nvim.desktop"];
                    "application/x-yaml"        = ["nvim.desktop"];
                    "application/x-shellscript" = ["nvim.desktop"];
                    "text/x-python"     = ["nvim.desktop"];
                    "text/x-csrc"       = ["nvim.desktop"];
                    "text/x-c++src"     = ["nvim.desktop"];
                    "text/html"         = ["nvim.desktop"];
                    "text/css"          = ["nvim.desktop"];
                    "application/javascript"    = ["nvim.desktop"];

                    # 🖼️ Images
                    "image/jpeg"        = ["feh.desktop"];
                    "image/png"         = ["feh.desktop"];
                    "image/gif"         = ["feh.desktop"];
                    "image/svg+xml"     = ["feh.desktop"];

                    # 🎬 Video
                    "video/mp4"         = ["vlc.desktop"];
                    "video/x-matroska"  = ["vlc.desktop"];
                    "video/webm"        = ["vlc.desktop"];

                    # 🧾 Documents
                    "application/pdf"   =  ["org.pwmt.zathura.desktop"];
                    "application/drawio" = [ "drawio.desktop" ];

                    # 🌐 Web/URI Handlers
                    "x-scheme-handler/http"     = ["zen.desktop"];
                    "x-scheme-handler/https"    = ["zen.desktop"];
                    "x-scheme-handler/ftp"      = ["zen.desktop"];
                    "x-scheme-handler/mailto"   = ["zen.desktop"];
                    "x-scheme-handler/magnet"   = ["zen.desktop"];
                };
            };

            userDirs = {
                enable = true;
                createDirectories = false;
            };
        };
    };
}
