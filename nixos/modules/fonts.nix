{pkgs,...}:
{
    fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;

        packages = with pkgs; [
           nerd-fonts.space-mono
           nerd-fonts.jetbrains-mono
           nerd-fonts.dejavu-sans-mono
        ]; 
    };
}
