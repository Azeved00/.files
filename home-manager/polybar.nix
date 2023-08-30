{ config, pkgs, libs, ...}:
{

xdg.configFile."launch.sh" = {
    enable = true;
    executable = true;
    text = ''
        killall -q polybar
        killall -q .polybar-wrapper

        echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
        polybar top 2>&1 | tee -a /tmp/polybar1.log & disown
    '';
    target = "polybar/launch.sh";
};

services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
        i3Support = true;
        alsaSupport = true;
        iwSupport = true;
        mpdSupport = true;
        pulseSupport = true;
    };

    settings = {
        "Acolors" = {
            background.text = "#222222";
            background.alt  = "#444444";
            foreground.text = "#dfdfdf";
            foreground.alt  = "#dfdfdf";
            primary         = "#ffb52a";
            secondary       = "#e60053";
            alert           = "#bd2c40";
        };

        "settings" = {
            screenchange.reload = true;
            #compositing.background = "xor"; # or screen
            #compositing.foreground = "source";
            #compositing.border = "over";
            #pseudo.transparancy = false
        };

        "global/wm" = {
            margin.top = 5;
            margin.bottom = 5;
        };

        "bar/top" = {
            width = "100%";
            height = 25;
            radius = 6.0;
            fixed.center = true;

            background = "\${Acolors.background}";
            foreground = "\${Acolors.foreground}";

            line.size = 3;
            line.color = "#f00";

            border.size = 6;
            border.color = "#000";

            padding.left = 0;
            padding.right = 2;

            module.margin.left = 1;
            module.margin.right = 1;

            font = [
                "SpaceMono Nerd Font Mono:style=Bold:size=13;"
                "DejaVu Sans Nerd Font Mono:style=Regular;"
                "JetBrainsMono Nerd Font Mono:style=Regular:pixelsize=12;1"
            ];

            modules.left = "i3 xwindow";
            modules.center = "date";
            modules.right = "temperature memory pulseaudio wlan powermenu";

            tray.position = "none";
            tray.padding = 2;

            cursor.click = "pointer";
            cursor.scroll = "ns-resize";
            separator = "|";
        };

        "module/xwindow" = {
            type = "internal/xwindow";
            label = "%title:0:30:...%";
        };

        "module/i3" = {
            type = "internal/i3";
            format = "<label.state> <label-mode>";
            index.sort = true;
            wrapping.scroll = false;

            ws.icon = [ "1;" "2;" "3;" "4;" "5;5" "6;6" "7;7" "8;8" ];

            label= {
                mode = {
                    padding = 2;
                    foreground = "#000";
                    background = "\${Acolors.primary}";
                };

                focused = {
                    text = "%icon%";
                    background = "\${Acolors.background-alt}";
                };

                unfocused = {
                    text = "%icon%";
                    padding = 2;
                };

                visible = {
                    text = "%icon%";
                    background = "\${self.label-focused-background}";
                    underline = "\${self.label-focused-underline}";
                    padding = "\${self.label-focused-padding}";
                };
                
                urgent = {
                    text = "%icon%";
                    background = "\${Acolors.alert}";
                    padding = 2;
                };
            };
        };

        "module/memory" = {
            type = "internal/memory";
            interval = 2;
            format.prefix = {
                text = "";
                foreground = "\${Acolors.foreground-alt}";
            };
            label = "%percentage_used%%";
        };

        "module/date" = {
            type = "internal/date";
            interval = 5;

            date.text = "\"  %d-%m-%Y  \"";
            date.alt = "";

            time.text = "%H:%M";
            
            format.prefix.text = "";
            format.prefix.foreground = "\${Acolors.foreground-alt}";

            label = "%date% %time%";
        };

        "module/batery" = {
            type = "internal/battery";
            battery = "BAT1";
            adapter = "ACAD";
            full-at = 98;

            format = {
                charging ="<animation-charging> <label-charging>";
                discharging.text = "<animation-discharging> <label-discharging>";
                discharging.underline = "\${self.format-charging-underline}";

                full = {
                    prefix.text = "";
                    prefix.foreground = "\${Acolors.foreground-alt}";
                    underline = "\${self.format-charging-underline}";
                };

                ramp.capacity.text = [" " "" ""];
                ramp.capacity.foreground = "\${Acolors.foreground-alt}";

                animation.charging = {
                    text = [" " "" ""];
                    foreground = "\${Acolors.foreground-alt}";
                    framerate = 750;
                };

                animation.discharging = {
                    text = ["" "" " "];
                    foreground = "\${Acolors.foreground-alt}";
                    framerate = 750;
                };
            };
        };

        "module/temperature" = {
            type = "internal/temperature";
            thermal-zone = 0;
            hwmon-path = "/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon1/temp1_input";

            interval = 0.5;
            base-temperature = 20;
            warn-temperature = 60;

            format.text = "<ramp> <label>";
            format.warn = "<ramp> <label-warn>";

            label.text = "%temperature-c%";
            label.warn.text = "%temperature-c%";
            label.warn.foreground = "\${Acolors.secondary}";

            ramp.text = ["" "" ""];
            ramp.foreground = "\${Acolors.foreground-alt}";
        };

        "module/powermenu" = {
            type = "custom/menu";

            expand-right = true;

            label = {
                open.text="";
                open.foreground="\${Acolors.secondary}";
                close.text=" cancel";
                close.foreground="\${Acolors.secondary}";
                separator.text = "|";
                separator.foreground = "\${Acolors.foreground-alt}";
            };

            menu = [
                [
                    {text = "reboot";    exec = "menu-open-1";}
                    {text = "power off"; exec = "menu-open-2";}
                ] 
                [
                    {text = "reboot";    exec = "reboot";}
                    {text = "cancel";    exec = "menu-open-0";}
                ]
                [
                    {text = "power off"; exec = "poweroff";}
                    {text = "cancel";    exec = "menu-open-0";}
                ]
            ];
        };

        "module/pulseaudio" = {
            type = "internal/pulseaudio";
            use.ui.max = true;
            interval = 5;
            
            format.volume = "<ramp-volume> <label-volume>";
            format.muted = "<label-muted>";

            label.muted.text = " muted";
            label.muted.foreground = "#66";
        
            ramp.volume = ["" "" ""];

            click-right = "pavucontrol &";
        };

        "module/bluetooth" = {
            type = "custom/script";
            exec = "$HOME/.config/polybar/scripts/rofi-bluetoth --status";
            interval = 5;
            click-left = "$HOME/.config/polybar/scripts/rofi-bluetooth &";
        };

        "module/wlan" = {
            type = "internal/network";
            interface = "wlp22s0f0u3";
            interval = 3.0;
            
            format.connected = "%{A1:bash $HOME/.config/polybar/scripts/rofi-wifi-menu.sh &:} <ramp-signal> <label-connected> %{A}";
            label.connected = "%essid%";

            format.disconnected = "%{A1:bash $HOME/.config/polybar/scripts/rofi-wifi-menu.sh &:} <label-disconnected> %{A}";
            label.disconnected.text = "%ifname% disconnected";
            label.disconnected.foreground = "\${Acolors.foreground-alt}";

            ramp.signal.text = ["" "" "" "" ""];
            ramp.signal.foreground = "\${Acolors.foreground-alt}";
        };
    };
};
}
