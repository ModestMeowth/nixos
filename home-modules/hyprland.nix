{
  home = {
    file = {
      ".local/bin/powermenu".source = ../dotfiles/bin/powermenu;
      ".local/bin/toggle-dnd".source = ../dotfiles/bin/toggle-dnd;
      ".local/bin/toggle-idle".source = ../dotfiles/bin/toggle-idle;
    };
  };

  xdg.configFile = {
    "hypr" = {
      source = ../dotfiles/hypr;
      recursive = true;
    };

    "mako" = {
      source = ../dotfiles/mako;
      recursive = true;
    };

    "uwsm" = {
      source = ../dotfiles/uwsm;
      recursive = true;
    };

    "walker" = {
      source = ../dotfiles/walker;
      recursive = true;
    };
    "waybar" = {
      source = ../dotfiles/waybar;
      recursive = true;
    };
  };
}
