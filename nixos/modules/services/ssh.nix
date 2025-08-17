{lib, config, ...}:
let
    cfg = config.dotfiles.nixos.ssh;
in
with lib;
{
    imports = [];


    options.dotfiles.nixos.ssh = {
        enable = mkEnableOption "Enable SSH module";
    };

    # udev rule
    config = mkIf cfg.enable {
        services = {
            openssh = {
              enable = true;
              settings = {
                PermitRootLogin = "no"; 
                PasswordAuthentication = false; 
              };
            };
        };
    };
}
