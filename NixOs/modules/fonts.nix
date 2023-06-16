{pkgs,...}:
{
    fonts = {
        enableDefaultFonts = true;
        fontDir.enable = true;

        fonts = with pkgs; [
            (nerdfonts.override { fonts = [
                "SpaceMono" 
                "JetBrainsMono"
                "DejaVuSansMono"
             ]; })
        ];
    };
}
