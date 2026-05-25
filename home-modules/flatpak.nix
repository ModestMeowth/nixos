{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    enable = true;
    packages = [ "com.github.tchx84.Flatseal" ];

    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
  };
}
