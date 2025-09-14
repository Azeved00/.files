{...}:
let
    port = 5984;
in
{
    services.couchdb = {
        enable = true;
        bindAddress = "0.0.0.0";
        port = port;
        adminUser = "admin";
        adminPass = "admin";
        #configFile = ./config.ini;
        extraConfig = {
            https.enable_cors = true;
            https.max_http_request_size = 4294967296;

            cors = {
                credentials = true;
                origins = "*";
                headers = "accept, authorization, content-type, origin, referer";
                methods = "GET, PUT, POST, HEAD, DELETE";
            };
        };
        # argsFile = config.services.couchdb.package/etc/vm.args";
    };
     
    networking.firewall.allowedTCPPorts = [ port ];
}


