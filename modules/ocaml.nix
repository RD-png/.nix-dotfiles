{ pkgs, ... }: {
  home.packages = with pkgs; [
    ocaml
    dune_3
    ocamlformat
    ocamlPackages.utop
    ocamlPackages.odoc
    ocamlPackages.ounit2
    ocamlPackages.qcheck
    ocamlPackages.bisect_ppx
    ocamlPackages.menhir
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat-rpc-lib
    ocamlPackages.findlib
  ];
}
