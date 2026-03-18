{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    orca-slicer
  ];

  networking.firewall.allowedUDPPorts = [
    1990
    2021
  ];
}
