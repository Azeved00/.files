{inputs}: let
  myLib = (import ./default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
in rec {
  # ================================================================ #
  # =                            My Lib                            = #
  # ================================================================ #

    # package helper
    mkPkgs = sys: (import inputs.nixpkgs {
        system = "${sys}";
        config = {allowUnfree = true;};
    });

    # building system
    mkSystem = sys: config: 
    inputs.nixpkgs.lib.nixosSystem {
        pkgs = mkPkgs sys;
        specialArgs = {
            inherit inputs outputs myLib;
            system = sys;
        };
        modules = [
            config
        ];
    };

    mkHome = sys: config: 
    inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs sys;
        extraSpecialArgs = {
            inherit inputs myLib outputs;
        };
        modules = [
            config
        ];
    };
