{pkgs ? import <nixpkgs> {
  inherit system;
}, system ? builtins.currentSystem}:

with pkgs;
let
  env_python_packages = packages: [  ] ;
  python' = (python35.buildEnv.override {
      #ignoreCollisions = true;
      extraLibs = with python35Packages; [
        # Add pythonPackages without the prefix
        pip
        virtualenv
        numpy
      ];
    });
  python_set = with pkgs; [
    python'
    vscode
  ];




in buildEnv { name = "python-env" ; paths = python_set; }









/*
with (import <nixpkgs> {}).pkgs;
stdenv.mkDerivation {
  name = "haskell-env";
  buildInputs = [ texlive.combined.scheme-full];
} */
