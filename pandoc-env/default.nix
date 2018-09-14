{pkgs ? import <nixpkgs> {
  inherit system;
}, system ? builtins.currentSystem}:

with pkgs;
let
  latex = pkgs.texlive.combine {
    inherit (texlive) scheme-basic;
  };


  # env-python-packages = packages: [ panflute ] ;
  # python = python3.withPackages env-python-packages;

  nixpkgs = with pkgs; [
    # nodejs
    vscode
    librsvg
    python
    pandoc
    texlive.combined.scheme-full
    haskellPackages.pandoc-citeproc
    zsh
  ];

  fixes = ''
    wrapProgram $out/bin/pandoc --add-flags --help
  '';

  inputs = nixpkgs;

  shell = pkgs.mkShell{name = "pandoc-shell"; buildInputs=inputs; shellHook="export SHELL=${pkgs.zsh}/bin/zsh "; };
  env = buildEnv {
    name = "pandoc-env";
    paths = inputs;
    buildInputs=[pkgs.makeWrapper];
    postBuild=fixes; };

in {
  inherit env;
  inherit shell;
}









/*
with (import <nixpkgs> {}).pkgs;
stdenv.mkDerivation {
  name = "haskell-env";
  buildInputs = [ texlive.combined.scheme-full];
} */
