{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.rustPlatform.buildRustPackage {
    pname = "dev_env";
    version = "0.1";
    cargoLock.lockFile = ./Cargo.lock;
    src = pkgs.lib.cleanSource ./.;
}
