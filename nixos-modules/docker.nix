{lib, ...}:
{
  virtualisation.docker = {
    enable = lib.mkDefault true;
    autoPrune = {
      enable = lib.mkDefault true;
      flags = lib.mkDefault ["--all"];
    };
  };
}
