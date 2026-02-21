{pkgs, ...}:
{
  services.kmscon = {
    enable = true;
    package = pkgs.unstable.kmscon;
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
