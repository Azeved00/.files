{config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.lf;
in
{

    options.dotfiles.home-manager.lf= {
        enable = lib.mkEnableOption "Enable LF module";
    };

    config = lib.mkIf cfg.enable {
        xdg.configFile."lf/icons".source = ./icons;
        xdg.configFile."lf/colors".source = ./colors;

        programs.lf = {
            enable = true;

            settings = {
                preview = true;
                hidden = true;
                drawbox = true;
                icons = true;
                ignorecase = true;
                # mouse = true;
            };

            commands = {
                edit = ''$$EDITOR $f'';
                mkdir = ''$mkdir $*'';
                touch = ''$touch $*'';
                unarchive = ''
                ''${{
                  case "$f" in
                      *.zip) ${pkgs.unzip}/bin/unzip "$f" ;;
                      *.tar.gz) tar -xzvf "$f" ;;
                      *.tar.bz2) tar -xjvf "$f" ;;
                      *.tar) tar -xvf "$f" ;;
                      *) echo "Unsupported format" ;;
                  esac
                }}
                '';
                zip = ''
                &{{
                    pushd $PWD
                    read -r -d '\n' -a split_array <<< "$fs"

                    # Map each element to a function
                    for i in "''${!split_array[@]}"; do
                        a="''$(basename "''${split_array[i]}")"
                        ${pkgs.zip}/bin/zip -u "$1" "$a"
                    done

                    popd
                }}'';
            };

            keybindings = {
                D = "delete"; 
                "." = "set hidden!"; 
                sf = "push :touch<space>";
                sd = "push :mkdir<space>";
            };
        };
    };
}
