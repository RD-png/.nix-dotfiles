{ config, pkgs, lib, ... }:
let
  configDir = config.home.homeDirectory;
in {
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        # REVIEW: This requires impure eval.
        configFile = super.writeText "config.h" (builtins.readFile "${configDir}/.config/dwm/config.h");
        postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${configFile} config.def.h";
        patches = [
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/rotatestack/dwm-rotatestack-20161021-ab9571b.diff";
            sha256 = "0g4g42sfzwzc8vravx9f18d55glkjr7hqg8iig6kkdg14ka8kj17";
          })
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/actualfullscreen/dwm-actualfullscreen-20191112-cb3f58a.diff";
            sha256 = "11fpzkq114p10bqrci6w3rmr57fx5182wi8r70yyxxlarkfank3v";
          })
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/attachasideandbelow/dwm-attachasideandbelow-20200702-f04cac6.diff";
            sha256 = "0qgqlm5kplf2whw7zk0r9bksynb2fp9zrv1c9dpc6bm6c97b2p1s";
          })
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/swallow/dwm-swallow-20201211-61bb8b2.diff";
            sha256 = "03553nrd6njkqg42ckwcmf08nzcn20w818a56nxb2771cc23l6gj";
          })
          
          # (super.fetchpatch {
          #   url = "https://dwm.suckless.org/patches/systray/dwm-systray-6.3.diff";
          #   sha256 = "1plzfi5l8zwgr8zfjmzilpv43n248n4178j98qdbwpgb4r793mdj";
          # })
        ];
      });
      # REVIEW: This requires impure eval.
      slstatus = super.slstatus.overrideAttrs (oldAttrs: rec {
        configFile = super.writeText "config.h" (builtins.readFile "${configDir}/.config/slstatus/config.h");
        postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${configFile} config.def.h";
      });
    })
  ];
  home.packages = with pkgs; [
    dwm
    slstatus
  ];
}
