{ system ? builtins.currentSystem ,  pkgs ? import <nixpkgs> { inherit system;} }:

with pkgs;
let
  /* environments and programs */
  self = {
      #inherit pkgs;
      pandoc = callPackage ./pandoc-env { pkgs = pkgs; };
      python = callPackage ./python-env { pkgs = pkgs; };
      rust = callPackage ./rust-env {  pkgs = pkgs; };
      php = callPackage ./php-env {  pkgs = pkgs; };
      bluredbreeze = libsForQt5.callPackage ./breeze-blur.nix { };
      inherit pkgs;

  };
in self
