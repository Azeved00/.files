{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.rustPlatform.buildRustPackage {
    pname = "i3_workspace_monitor";
    version = "0.1.0";
    cargoLock.lockFile = ./Cargo.lock;
    src = pkgs.lib.cleanSource ./.;
}
