{pkgs, ...}:
{
  services.kmscon = {
    enable = true;
    package = pkgs.unstable.kmscon;
    hwRender = true;
    extraOptions = ''--xkb-options="ctrl:swapcaps"'';
    # extraConfig = ''
    #   font-engine=pango
    # '';
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
