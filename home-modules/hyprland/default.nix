{ ezModules, ... }:
{
  imports = [
    ezModules.walker

    # ./hypridle.nix
    ./scripts.nix
    ./shell.nix
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];

  catppuccin.hyprland.enable = false;

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    configType = "lua";
    extraConfig = #lua
    ''
      local HOME = os.getenv("HOME")
      local XDG = os.getenv("XDG_CONFIG_HOME") or (HOME .. "./config")

      package.path = package.path .. ";" .. XDG .. "/hypr" .. "/?.lua"

      local function try_require(name)
        if package.searchpath(name, package.path) then
          require(name)
        end
      end

      try_require("monitors")
      try_require("bindings.tiling")
      try_require("bindings.apps")
      try_require("bindings.utils")
    '';
  };
}
