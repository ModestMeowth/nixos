{pkgs, ...}:
{
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
    };
  };

  environment.systemPackages = [ pkgs.impala ];
}
