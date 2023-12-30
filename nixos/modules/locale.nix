{...}:
let
    EN = "en_US.UTF-8";
    PT = "pt_PT.UTF-8";
in
{
    # Set your time zone.
    time.timeZone = "Europe/London";

    # Select internationalisation properties.
    i18n = {
        supportedLocales = [ "en_US.UTF-8/UTF-8" "pt_PT.UTF-8/UTF-8"];
        defaultLocale = EN ;
        extraLocaleSettings = {
            LANG = EN;
            LC_MESSAGES = EN;
            
            LC_NUMERIC = PT;
            LC_TIME = PT;
        };
    };

    console = {
        font = "jetbrains-mono";
        # keyMap = "pt";
        useXkbConfig = true; 
    };
}
