{pkgs, ...}: let
  theme = "border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --cmd Hyprland --theme ${theme}";
        user = "greeter";
      };
    };
  };
}
