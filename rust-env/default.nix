{
  system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> {inherit system;},
  stdenv, collections, collectionWith
}:

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

in {
  env = collectionWith { name="rust"; inputs = progs ++ rust_set; };
}
