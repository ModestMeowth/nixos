{
  den.aspects.desktop._.dms = {
    nixos =
      {config, lib, pkgs, ...}:
      let
        cfg = config.services.tailscale;
      in
      {
        services.displayManager.dms-greeter = {
          enable = true;
        };

        programs.dms-shell.enable = true;
        environment.systemPackages = with pkgs; [
          adw-gtk3
          (lib.mkIf cfg.enable cfg.package)
        ];
      };
  };
}
