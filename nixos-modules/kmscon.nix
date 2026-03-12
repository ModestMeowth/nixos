{pkgs, ...}:
{
  services.kmscon = {
    enable = true;
    hwRender = true;
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
