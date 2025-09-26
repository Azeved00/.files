{lib, config, ...}:
{
    services ={
        influxdb = {
            enable = true;
        };

        telegraf = {
            enable = true;
            extraConfig = {
                inputs = {
                    cpu  = {
                        percpu = true;
                        totalcpu = true;
                        collect_cpu_time = false;
                        report_active = false;
                    };
                    mem = {};
                    disk = {
                        mount_points = ["/"];
                    };
                    net = {};
                    system = {};
                    netstat = {};
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
              serve_from_sub_path = false;
            };
          };
        };
    };

    # this is so that the domain is not publicly available
    systemd.services.grafana.serviceConfig.EnvironmentFile =
      config.sops.secrets."grafana/env".path;
}

