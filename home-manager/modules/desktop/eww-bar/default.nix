{config, lib, ...}:with lib;
let
    cfg = config.dotfiles.home-manager.desktop.eww;
    workspaceapp = import ./scripts/workspace/package.nix (pkgs);
in
{
    options.dotfiles.home-manager.desktop.eww = {
        enable = mkEnableOption "Enable eww bar module";
    };

    config = mkIf cfg.enable {
        buildInputs = [workspaceapp];

        programs.eww = {
            enable = true;
            configDir = ./.;
        };
        
    };
}
