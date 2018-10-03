{pkgs ? import <nixpkgs> {
  inherit system;
}, system ? builtins.currentSystem}:

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

  shell = mkShell{name = "pandoc-shell"; buildInputs=inputs; shellHook="export SHELL=${pkgs.zsh}/bin/zsh "; };
  env = buildEnv {
    name = "pandoc-env";
    paths = inputs;
    buildInputs=[pkgs.makeWrapper];
    postBuild=""; };

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
