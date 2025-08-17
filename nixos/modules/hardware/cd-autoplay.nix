{lib, config, pkgs, ...}:
let
    cfg = config.dotfiles.nixos.cd-autoplay;
    script =   pkgs.writeShellScriptBin "cd-autoplay" ''
        USER="azevedo"
        DISPLAY=":0"
        XAUTHORITY="/home/$USER/.Xauthority"
        XDG_RUNTIME_DIR="/run/user/$(id -u $USER)"
        VLC_CMD="vlc cdda:///dev/sr0"

        if blkid /dev/sr0; then
            logger "CD inserted - launching VLC GUI"
            cvlc --play-and-exit /dev/sr0
            #sudo -u "$USER" XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" systemd-run --user --scope $VLC_CMD
        fi
    '';
    udevrule = pkgs.writeTextFile {
        name = "60-cd-autoplay";
        text = ''KERNEL=="sr0", ACTION=="change",RUN+="${script}/bin/cd-autoplay"'';
        destination = "/etc/udev/rules.d/60-cd-autoplay.rules";
    };
in
with lib;
{
    imports = [];

    options.dotfiles.nixos.cd-autoplay = {
        enable = mkEnableOption "Enable CD Autoplay";
        block-device = mkOption { default = "sr0"; };
        user = mkOption {default = "azevedo";};
    };

    # udev rule
    config = mkIf cfg.enable {
        services.udev.packages = [udevrule];
    };
}
