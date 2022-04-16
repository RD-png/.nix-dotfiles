{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    (final: prev:
      {
        erlang-ls = prev.erlang-ls.overrideAttrs (old: rec {
          version = "0.28.0";
          name = "erlang-ls-${version}";
          src = prev.fetchFromGitHub {
            owner = "erlang-ls";
            repo = "erlang_ls";
            rev = "a9727c943ed630c88600ca625310d27d0b12b054";
            sha256 = "sha256-4Gwd7lHJbhFsCpIRdTseOIcyZBG/wn4bAQiKym1zGXg=";
          };
        });
      })
  ];
}
