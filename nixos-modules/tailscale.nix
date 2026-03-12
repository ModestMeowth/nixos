{
  config,
  lib,
  ...
}:
let
  secrets = config.sops.secrets;
  flags = [
    "--ssh"
    "--operator=mm"
  ];
in
{
  services.tailscale = {
    enable = true;
    authKeyFile = lib.mkIf (builtins.hasAttr "tskey" secrets) secrets."tskey".path;
    extraUpFlags = lib.mkDefault (flags ++ [ "--reset" ]);
    extraSetFlags = lib.mkDefault flags;
    openFirewall = true;
    useRoutingFeatures = lib.mkDefault "client";
  };
}
