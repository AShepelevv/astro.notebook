{
  system ? builtins.currentSystem,
  sources ? import ./npins,
  nixpkgs ? sources.nixpkgs,
  pkgs ? import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  },
}:
let
  texlive = pkgs.callPackage ./nix/texlive.nix { };
  build-notebook = pkgs.writeShellScriptBin "build-notebook" ''
    mkdir -p tikz/resource
    latexmk -pdf -xelatex -shell-escape astro-notebook.tex
  '';
  astro-notebook = pkgs.callPackage ./nix/package.nix { inherit texlive; };
in
astro-notebook
// {
  shell = pkgs.mkShellNoCC {
    packages = [
      texlive
      build-notebook
    ];
  };
}
