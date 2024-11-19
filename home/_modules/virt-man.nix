{ config, lib, pkgs, ... }: with lib; let
  cfg = config.modules.virt-man;
in
{
  options.modules.virt-man.enable = mkEnableOption "virt-man";

  config = mkIf cfg.enable {
    home.packages = [ pkgs.virt-manager ];

    dconf.settings =
      let
        inherit (hm.gvariant) mkTuple mkUint32;
      in
      {
        "org/virt-manager/virt-manager" = {
          "connections.autoconnect" = [ "qemu:///system" ];
          "connections.uris" = [ "qemu:///system" ];
          "conns/qemu:system/pretty-name" = "System";
        };
      };
  };
}
