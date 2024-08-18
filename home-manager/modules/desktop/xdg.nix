{...}:
{
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
}
