{
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> {inherit system;},
  stdenv, collections, collectionWith
}:

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

in
 {
   env = collectionWith { name="php"; inherit inputs; };
 }
