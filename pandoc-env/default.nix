{
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> {inherit system;},
  stdenv, collections, collectionWith
}:

with pkgs;
let

  latex = texlive.combine {
    inherit (texlive) scheme-small
    collection-langgerman
    collection-latexextra
    collection-mathscience ;
    #isodate substr lipsum nonfloat supertabular;
  };


  # env-python-packages = packages: [ panflute ] ;
  # python = python3.withPackages env-python-packages;

  nixpkgs = [
    # nodejs
    vscode
    librsvg
    python
    pandoc
    haskellPackages.pandoc-citeproc
    zsh
  ];

  fixes = ''
    wrapProgram $out/bin/pandoc --add-flags --help
  '';

  inputs = nixpkgs ++ [latex];

in {
  env = collectionWith {
    name = "LaTeX";
    inherit inputs;
  };
  inherit latex;
}









/*
with (import <nixpkgs> {}).pkgs;
stdenv.mkDerivation {
  name = "haskell-env";
  buildInputs = [ texlive.combined.scheme-full];
} */
