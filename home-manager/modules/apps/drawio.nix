{config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.drawio;
in
{
    options.dotfiles.home-manager.drawio = {
        enable = lib.mkEnableOption "Enable Drawio Module";
    };

    config = lib.mkIf cfg.enable {
        home.packages = with pkgs; [ drawio ];

        xdg = {
            enable = true;
            mimeApps.enable = true;

            mimeApps.defaultApplications."application/drawio" = [ "drawio.desktop" ];

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

        };
    };
}


