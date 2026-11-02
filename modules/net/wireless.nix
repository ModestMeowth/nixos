{
  den.aspects.net._.wireless = {
    nixos =
      {lib, ...}:
      let
        inherit (lib) mkDefault mkForce;
      in
      {
        systemd.network.enable = mkForce false;
        networking.networkmanager = {
          enable = mkDefault true;
          wifi.backend = "iwd";
        };
      };
  };
}
