{ system ? builtins.currentSystem ,  pkgs ? import <nixpkgs> { inherit system;} }:

with pkgs;
let
  /* environments and programs */
  self = {
      #inherit pkgs;
      pandoc = callPackage ./pandoc-env { pkgs = pkgs; };
      python = callPackage ./python-env { pkgs = pkgs; };
      rust = callPackage ./rust-env {  pkgs = pkgs; };
      inherit pkgs;

  };
in self
