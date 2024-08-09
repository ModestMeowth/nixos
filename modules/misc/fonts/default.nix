{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hostConfig.misc = {
    fonts = lib.mkEnableOption "fonts";
  };

  config = lib.mkIf config.hostConfig.misc.fonts {
    fonts.packages = with pkgs; [
      nerdfonts
      unifont
    ];
  };
}
