{...}:
let
    webdavDir = "/var/lib/webdav";
in
{

      users.users.webdav = {
        isSystemUser = true;
        home = webdavDir;
      };

     # Create the directory with proper permissions
      systemd.tmpfiles.rules = [
        "d ${webdavDir} 0750 webdav webdav -"
      ];

    services.webdav = {
        enable = true;
        user = "webdav";
        group = "webdav";
        settings = {
            address = "0.0.0.0";
            port = 8080;
            scope = "/srv/public";
            directory=webdavDir;
            permissions="CRUD";
            users = [
              {
                username = "az";
                password = "aze1";
              }
            ];
        };
        environmentFile = null;
    };
     
    networking.firewall.allowedTCPPorts = [ 8080 ];
}


