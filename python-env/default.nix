{
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> {inherit system;},
  stdenv, collections, collectionWith
}:

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
  ]++env_python_packages;




in collectionWith { name = "python-env" ; inputs = python_set; }









/*
with (import <nixpkgs> {}).pkgs;
stdenv.mkDerivation {
  name = "haskell-env";
  buildInputs = [ texlive.combined.scheme-full];
} */
