{ system ? builtins.currentSystem ,  pkgs ? import <nixpkgs> { inherit system;} }:

with pkgs;
let

  /* make shell and env */
  collectionWith = {name, inputs, shellHook ? ""}:
    let
      shell = mkShell {
        name="${name}-collection";
        buildInputs=inputs;
        inherit shellHook;
        env = buildEnv {inherit name; paths = inputs;};
      };
    in if lib.inNixShell then shell else shell.env;

  callPackage' = path: args:
    callPackage path {inherit collectionWith; inherit pkgs; collections = self;} // args;

  /* environments and programs */
  self = {
      #inherit pkgs;
      pandoc = callPackage' ./pandoc-env { };
      python = callPackage' ./python-env { };
      rust = callPackage' ./rust-env { };
      php = callPackage' ./php-env { };
      misc = callPackage' ./misc { };
      bluredbreeze = libsForQt5.callPackage ./breeze-blur.nix { };
      inherit collectionWith;
      inherit pkgs;

  };
in self
