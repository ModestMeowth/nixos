{lib, ...}:
{
  services.cockpit = {
    enable = lib.mkDefault true;
    openFirewall.enable = lib.mkDefault true;
  };
}
