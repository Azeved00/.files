{config, pkgs, lib, ...}:
{
    xsession.windowManager.i3 = {
        enable = true;
        config = {
            

            modifier = "Mod4";
            fonts = ["pango:monospace 15"];
            terminal = "alacritty";
            titlebar = false;

            gaps.inner = 10;
            gaps.outer = 5;
            window.border = 1;
            floating = {
                modifier = "Mod4";
                titlebar = false;
                border = 1;
            };
            
            assigns = {
                "1" = [{class="firefox";];
                "2" = [
                    {class="Alacritty";}
                    {class="Develop*";}
                    ];
                "3" = [];
                "4" = [
                    {class = "prismlauncher";}
                    {class = "dolphin-emu";}
                    {class = "Mnecraft*";}
                    {class = "steam";}
                    {class = "explorer.exe";}
                    {class = "leagueclientux*";}
                    {class = "leagueP";}
                    {class = "Poke*";}
                ];
            };

            keybindings = let 
                modifier = config.xsession.windowManager.i3.config.modifier;
            in lib.mkOptionDefault {
                "${modifier}+r" = ''mode "resize"'';
            };

            startup = [
                {
                    command = "${config.xdg.configHome}/polyvar/launch.sh";
                    always = true;
                    notification = false;
                }
                {
                    command = "picom --config ${config.xdg.configHome}/picom/picon.conf";
                    always = true;
                    notification = false;
                }
                {
                    command = "feh --no-fehbg --bg-fill ${config.home.homeDirectory}/Pictures/Backgrounds/download1.jpeg --bg-fill ${config.home.homeDirectory}/Pictures/Backgrounds/download1.jpeg";
                    always = true;
                    notification = false;
                }
                {
                    command = "playerctld daemon";
                    always = false;
                    notification = false;
                }
                
                {
                    command = "xrandr --output DP-1 --mode 1280x800";
                    always = true;
                    notification = false;
                }
                {
                    command = "xrandr --output HDMI-1 --primary --right-of DP-1 --auto";
                    always = true;
                    notification = false;
                }
            ];

            modes = {
                resize = {
                    j = resize "resize shrink width 10 px or 10 ppt"; 
                    k = resize "resize grow height 10 px or 10 ppt";
                    l = resize "resize shrink height 10px or 10 ppt";
                    SemiColon = "resize grow width 10 px or 10 ppt";

                    Left    = "resize shrink width 10 px or 10 ppt";
                    Up      = "resize shrink height 10 px or 10 ppt";
                    Down    = "resize grow height 10 px or 10 ppt";
                    Right   = "resize grow width 10 px or 10 ppt";
                    
                    Return = "mode default";
                    Escape = "mode default";
                };
            };
        };
    };
}
