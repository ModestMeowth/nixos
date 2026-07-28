{inputs, ...}:
{
  den.aspects.desktop._.quickshell = {
    homeManager = {
      programs.quickshell = {
        enable = true;
        systemd.enable = true;
      };

      # xdg.configFile."quickshell" = {
      #   source = inputs.self + /dotfiles/quickshell;
      #   recursive = true;
      # };
    };
  };
}
