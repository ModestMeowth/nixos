{
  den.aspects.desktop._.dms = {
    nixos = {
      services.displayManager.dms-greeter = {
        enable = true;
      };

      programs.dms-shell.enable = true;
    };
  };
}
