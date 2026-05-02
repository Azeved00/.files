{lib, pkgs, ...}:
let
    vs-latest = pkgs.callPackage ./vintagestory.nix {};
in
{

    imports = [ ./hardware.nix ];

    networking.hostName  = "blizzard";
    dotfiles.nixos.xserver.layout = "us";
    dotfiles.nixos.ssh.enable = true;
    bright-bit.system.sddm.theme-config = ''
                [General]
                clockEnabled="true"
                clockSize=40
    '';
    services.xserver.xrandrHeads = [
        {
            output = "HDMI-1";
            primary = true;
            #   DisplaySize 1920 1080
            monitorConfig = ''
            '';
        }
        {
            output = "DP-3";
            #   DisplaySize 1920 1080
            primary = false;
            monitorConfig = ''
                Option "RightOf" "HDMI-1"
            '';
        }
    ];

    dotfiles.nixos.xserver.enable = true;
    dotfiles.nixos.wayland.enable = false;
    dotfiles.nixos.docker.enable =false;

    environment.systemPackages =[];
    services.kanidm = {
        package = pkgs.kanidm_1_7;
        enableClient = true;
        clientSettings.uri = "https://auth.jazevedo.dev";
    };


    specialisation = {
        gaming.configuration = {
            system.nixos.tags = [ "Gaming" ];

            programs.gamemode.enable = true;

            programs.steam = {
                enable = true;
                # Open ports in the firewall for Steam Remote Play
                remotePlay.openFirewall = false;
                # Open ports in the firewall for Source Dedicated Server
                dedicatedServer.openFirewall = false; 
                gamescopeSession.enable = false;
            };

            environment.systemPackages = with pkgs; [
                mangohud
                prismlauncher
                heroic
                (retroarch-bare.wrapper {
                    cores = with libretro; [
                        dolphin
                        #citra
                        beetle-gba
                        beetle-psx-hw
                        #pcsx2
                    ];
                })
                vs-latest
            ];

        };
        
        server.configuration = {
            system.nixos.tags = [ "Headless" ];

            dotfiles.nixos.xserver.enable = lib.mkForce false;
            dotfiles.nixos.wayland.enable = lib.mkForce false;

            #networking.firewall.allowedTCPPorts = [22];
        };
    };
}
