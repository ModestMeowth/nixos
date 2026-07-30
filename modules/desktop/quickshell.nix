{inputs, ...}:
{
  den.aspects.desktop._.quickshell = {
    homeManager = {
      programs.quickshell = {
        enable = true;
        systemd.enable = true;
      };
    };
  };
}
