{
  den.aspects.desktop._.dms = {
    nixos =
      {config, lib, pkgs, ...}:
      let
        cfg = config.services.tailscale;
      in
      {
        services.displayManager.dux-greeter = {
          enable = lib.mkDefault true;
          configHome = "/home/mm";
        };

        programs.dux-shell.enable = true;
        environment.systemPackages = with pkgs; [
          adw-gtk3
          (lib.mkIf cfg.enable cfg.package)
        ];
      };
  };
}
