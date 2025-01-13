{ config, lib, pkgs, ... }:
let
  cfg = config.programs.fish;
in
{
  programs.fish = lib.mkIf cfg.enable {
    plugins = with pkgs.fishPlugins; [
      {
        name = "abbreviation-tips";
        src = pkgs.fish-plugins.abbreviation-tips.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "bass";
        src = bass.src;
      }
    ];

    interactiveShellInit = lib.mkBefore # fish
      ''
        set -g fish_greeting
        fish_vi_key_bindings
        set -e DIRENV_CONFIG
      '';

    shellAbbrs = {
      ssh = "mosh";
      j = "just";

      # git
      g = "git";
      ga = "git add";
      clone = "git clone";
      co = "git switch";
      cz = "git cz c";

      # eza
      ls = "eza --icons --sort=type";
      ll = "eza -lg --icons --sort=type";
      la = "eza -lag --icons --sort=type";
      tree = "eza --icons --tree";

      # zoxide
      cd = "z";
      ci = "zi";
    };
  };
}
