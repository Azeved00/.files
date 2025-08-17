{lib, config, ...}:
let
    cfg = config.dotfiles.nixos.tlp;
in
with lib;
{
    imports = [];

    options.dotfiles.nixos.tlp = {
        enable = mkEnableOption "enable tlp";

    };

    config = mkIf cfg.enable {
        
        services.tlp = {
            enable = true;
            settings = {
                TLP_ENABLE=1;
                DISK_IDLE_SECS_ON_BAT=2;
                MAX_LOST_WORK_SECS_ON_BAT=60;
                CPU_HWP_ON_AC="balance_performance";
                CPU_HWP_ON_BAT="balance_power";
                SCHED_POWERSAVE_ON_BAT=1;
                ENERGY_PERF_POLICY_ON_BAT="powersave";
                DISK_APM_LEVEL_ON_BAT="128 128";
                SATA_LINKPWR_ON_BAT="min_power";
                PCIE_ASPM_ON_BAT="powersave";
                RADEON_POWER_PROFILE_ON_BAT="low";
                RADEON_DPM_STATE_ON_BAT="battery";
                RADEON_DPM_PERF_LEVEL_ON_BAT="auto";
                WIFI_PWR_ON_BAT="on";
                SOUND_POWER_SAVE_ON_BAT=1;
                RUNTIME_PM_ON_BAT="auto";
                USB_AUTOSUSPEND=1;
                USB_BLACKLIST_WWAN=1;
            };

        };
    };

}
