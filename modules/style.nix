{ pkgs, ... }: {
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  };
}
