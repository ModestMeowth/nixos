{ config, lib, pkgs, ... }:
let
  cfg = config.programs.wezterm;
  theme = pkgs.dracula.wezterm.theme;
in
{
  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "wezterm/wezterm.lua".text = lib.mkForce # lua
        ''
          local wt = require "wezterm"
          local config = {}

          local wayland_gnome = require "wayland_gnome"
          wayland_gnome.apply_to_config(config)

          config.color_scheme = "Dracula (Official)"
          config.front_end = "WebGpu"

          config.font_size = 11.0
          config.font = wt.font {
            family = "NotoSansM Nerd Font Mono",
            weight = "DemiBold",
          }

          config.tab_bar_at_bottom = true
          config.use_fancy_tab_bar = false

          config.window_close_confirmation = "NeverPrompt"

          config.hyperlink_rules = wt.default_hyperlink_rules()

          table.insert(config.hyperlink_rules, {
            regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
            format = "https://github.com/$1/$3",
          })

          config.keys = require "keybinds"
          wt.on("update-right-status", function(window, _)
            local leader = ""
            if window:leader_is_active() then
              leader = "LEADER"
            end
            window:set_right_status(leader)
          end)

          return config
        '';

      "wezterm/wayland_gnome.lua".text = # lua
        ''
          local wt = require "wezterm"
          local mod = {}

          local function gsettings(key)
            return wt.run_child_process({
              "gsettings",
              "get",
              "org.gnome.desktop.interface",
              key
            })
          end

          function mod.apply_to_config(config)
            if wt.target_triple ~= "x86_64-unknown-linux-gnu" then
              return
            end

            local success,stdout,_

            success,stdout,_ = gsettings("cursor-theme")
            if success then
              config.xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
            end

            success,stdout,_ = gsettings("cursor-size")
            if success then
              config.xcursor_size = tonumber(stdout)
            end

            config.enable_wayland = true

            if config.enable_wayland and os.getenv("WAYLAND_DISPLAY") then
              success,stdout,_ = gsettings("text-scaling-factor")
              if success then
                config.font_size = (config.font_size or 11.0) * tonumber(stdout)
              end
            end
          end

          return mod
        '';

      "wezterm/keybinds.lua".text = # lua
        ''
          local wt = require "wezterm"
          return {}
        '';

      "wezterm/colors/dracula.toml".text = theme;
    };
  };
}
