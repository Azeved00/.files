{lib, config, ...}:
{

    imports = [ ./hardware.nix ./users.nix];
     
    dotfiles.nixos.xserver.enable = false;
    dotfiles.nixos.ssh.enable = true;
    dotfiles.nixos.docker.enable = true;
    dotfiles.nixos.gui = false;
    sops.age.keyFile = lib.mkForce "/root/.config/sops/age/keys.txt";

    services ={

        openssh.settings = {
            PermitRootLogin = lib.mkForce "yes"; 
        };

        cloudflared = {
            enable = true;
            tunnels = {
              "Grafana" = {
                credentialsFile = config.sops.secrets."cloudflared/grafana-tunnel/tunnel-credentials".path;
                default = "http_status:404";
              };
            };
        };

        # Esp to grafana pipeline
        mosquitto = {
          enable = true;
          listeners = [
            {
              acl = [ "pattern readwrite #" ];
              omitPasswordAuth = true;
              settings.allow_anonymous = true;
            }
          ];
        };

        influxdb = {
            enable = true;
        };

        telegraf = {
            enable = true;
            extraConfig = {
                inputs = {
                    mqtt_consumer = {
                        servers = ["tcp://localhost:1883"];
                        topics = ["home/garden"];
                        data_format = "json";
                    };
                    cpu  = {
                        percpu = true;
                        totalcpu = false;
                        collect_cpu_time = false;
                        report_active = false;
                    };
                    mem = {};
                    disk = {
                        mount_points = ["/"];
                    };
                };
                outputs = {
                    influxdb = {
                        database = "sensor_data";
                        urls = ["http://localhost:8086"];
                    };
                };
            };
        };
        grafana = {
          enable = true;
          settings = {
            server = {
              http_addr = "0.0.0.0";
              http_port = 3000;
              domain = "graphs.jazevedo.dev";
              serve_from_sub_path = false;
            };
          };
        };
    };

            
    networking.hostName = "tundra";
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 1883 3000];
    };

    system.autoUpgrade.enable = true;

}

