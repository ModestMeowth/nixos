{ config, lib, pkgs, ... }: {
  config = lib.mkIf (builtins.elem pkgs.virt-manager config.home.packages) {
    dconf.settings = {
      "org/virt-manager/virt-manager" = {
        "connections.autoconnect" = [ "qemu:///system" ];
        "connections.uris" = [ "qemu:///system" ];
        "conns/qemu:system/pretty-name" = "System";
      };
    };
  };
}
