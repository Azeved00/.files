{ pkgs ? import <nixpkgs> { }, ... }:

pkgs.rustPlatform.buildRustPackage {
    pname = "dev";
    version = "0.1";
    cargoLock.lockFile = ./Cargo.lock;
    src = pkgs.lib.cleanSource ./.;
}
