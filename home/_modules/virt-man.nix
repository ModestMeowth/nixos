{ config, lib, pkgs, ... }: let
  uris = [
    "qemu+ssh://mm@pwnyboy.cat-alkaline.ts.net/system"
  ];
in {
  config = lib.mkIf (builtins.elem pkgs.virt-manager config.home.packages) {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        "autoconnect" = uris;
        "uris" = uris;
      };
    };
  };
}
