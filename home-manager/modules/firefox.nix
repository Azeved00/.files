{config, lib, pkgs, ...}: with lib;
let
    cfg = config.dotfiles.home-manager.firefox;
in
{

    options.dotfiles.home-manager.firefox = {
        enable = mkEnableOption "Enable Firefox home-manager module";
        profile = mkOption {
            description = "Profile to activate firefox";
            type = types.str;
            default = "default";
        };
    };

    config = mkIf cfg.enable {

        programs.firefox = {
            enable = true;
            profiles."${cfg.profile}" = {
                settings = {
                    "browser.aboutConfig.showWarning" = false;
                    "browser.tabs.warnOnClose" = false;
                    "widget.use-xdg-desktop-portal" = true;
                    "browser.bookmarks.showMobileBookmarks" = false;

                    "browser.theme.content-theme" = 0;
                    "browser.theme.toolbar-theme" = 0;
                };
                search = {
                    force = true;
                    default = "Brave Search";
                    privateDefault = "Brave Search";
                    engines = {
                        "Nix Packages" = {
                            urls = [{
                                template = "https://search.nixos.org/packages";
                                params = [
                                    { name = "type"; value = "packages"; }
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }];

                            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                            definedAliases = [ "@nixpkgs" ];
                        };

                        "NixOS Wiki" = {
                            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                            iconUpdateURL = "https://nixos.wiki/favicon.png";
                            updateInterval = 24 * 60 * 60 * 1000; # every day
                            definedAliases = [ "@nixwiki" ];
                        };

                        "Brave Search" = {
                            urls = [{
                                template = "https://search.brave.com/search";
                                params = [
                                    { name = "q"; value = "{searchTerms}"; }
                                ];
                            }];
                            definedAliases = [ "@brave" ];
                        };

                        "Home-Manager Option Search" = {
                            urls = [{
                                template = "https://home-manager-options.extranix.com/?";
                                params = [
                                    { name = "query"; value = "{searchTerms}"; }
                                ];
                            }];
                            definedAliases = [ "@hmoptions" ];
                        };
                    };
                };
            };
        };

    };

}
