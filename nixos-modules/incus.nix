{lib, ...}:
let
  incusIf = "incusbr0";
in
{
  virtualisation.incus = {
    enable = true;
    ui.enable = lib.mkDefault true;
  };

  networking = {
    # Incus require NFTables
    nftables.enable = true;

    firewall.interfaces.${incusIf} = {
      allowedTCPPorts = [ 53 67 ];
      allowedUDPPorts = [ 53 67 ];
    };
  };
}
