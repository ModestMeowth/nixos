{config, lib, pkgs, ...}:
let
  cfg = config.fleet.isServer;
  reportLib = import ./firewall-report.nix;
  mkFirewallReport = reportLib.mkFirewallReport;
in
{
  options.fleet.isServer = lib.mkEnableOption "device is a server";

  config = lib.mkIf cfg {
    system.build.firewallReport = pkgs.writeText "firewall-report"
      (lib.concatStringsSep "\n"
        (lib.flatten [
          (mkFirewallReport "" config.networking.firewall)
          (map ({name, value}:
            mkFirewallReport name value)
              (lib.attrsToList config.networking.firewall.interfaces))
      ]));

    environment.etc."nixos/firewall-report".source = config.system.build.firewallReport;
  };
}
