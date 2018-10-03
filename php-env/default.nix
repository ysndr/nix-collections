{pkgs ? import <nixpkgs> {
  inherit system;
}, system ? builtins.currentSystem, stdenv}:

with pkgs;
let

  progs = [
    jetbrains.phpstorm
  ];


  php-progs = [
    php72
    docker_compose
  ] ++ (with php72Packages; [
      composer
    ]);

  inputs = php-progs ++ progs;
  shell = pkgs.mkShell{name = "php-shell"; buildInputs=inputs; shellHook="";};
  env = buildEnv { name = "php-env" ; paths = inputs; postBuild="export BAR='foo'"; };
in
 {
   inherit shell;
   inherit env;
 }
