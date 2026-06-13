{ pkgs, ... }:
{
  services.kmscon = {
    enable = true;
    config.hwaccel = true;
  };

  stylix.targets.kmscon = {
    enable = true;
    fonts.override = {
      monospace = {
        name = "Unifont";
        package = pkgs.unifont;
      };
    };
  };
}
