{lib, config, ...}:
let
    cfg = config.dotfiles.nixos.bluetooth;
in
with lib;
{

    options.dotfiles.nixos.bluetooth= {
        enable = mkEnableOption "Enable bluetooth module";
        controller = mkOption {
            default = "quininha";
            type = types.str;
            description = "Bluetooth controller";
        };
    };

    config = mkIf cfg.enable {
        hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
    };
}
