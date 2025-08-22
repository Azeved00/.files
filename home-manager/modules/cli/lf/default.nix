{config, lib, pkgs, ...}:
let 
    cfg = config.dotfiles.home-manager.lf;
in
{

    options.dotfiles.home-manager.lf= {
        enable = lib.mkEnableOption "Enable LF module";
    };

    config = lib.mkIf cfg.enable {
        programs.bash.shellAliases."lf" = ''cd "$(command lf -print-last-dir "$@")"'';

        programs.lf = {
            enable = true;

            settings = {
                preview = true;
                hidden = false;
                drawbox = true;
                icons = true;
                ignorecase = true;
                number = true;
                mouse = true;
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
                copy-name = ''
                ''${{
                    printf "$fx" | xclip -selection clipboard
                }}
                '';
            };

            keybindings = {
                D = "delete"; 
                "." = "set hidden!"; 
                sf = "push :touch<space>";
                sd = "push :mkdir<space>";
                gtD = ''cd ~/Dev"'';
                gtd = ''cd ~/Downloads'';
                gth = ''cd ~'';
                yn = '' copy-name'';
            };
        };
    };
}
