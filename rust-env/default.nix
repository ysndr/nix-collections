{pkgs ? import <nixpkgs> {
  inherit system;
}, system ? builtins.currentSystem, stdenv}:

with pkgs;
let

  progs = [
    vscode
  ];


  rust_set = [
    rustup
    racer
    gcc
    cmake
    pkgconfig
    zlib
    gnumake
    binutils.bintools
  ];

  inputs = rust_set ++ progs;
  shell = pkgs.mkShell{name = "rust-shell"; buildInputs=inputs; shellHook="";};
  env = buildEnv { name = "rust-env" ; paths = inputs; postBuild="export BAR='foo'"; };
  test = runCommand "test" {shellHook="export BAR=foo; echo 'hello'";} "echo here";
in
 {
   inherit shell;
   inherit env;
   inherit test;
 }
