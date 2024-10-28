{ config, lib, pkgs, myPkgs, ... }: with lib; let
  cfgFish = config.programs.fish;
  cfgFzf = config.programs.fzf;
in
{
  programs.fish = mkIf cfgFish.enable {
    plugins = with pkgs.fishPlugins; mkMerge [
      ([
        {
          name = "puffer";
          src = puffer.src;
        }
        {
          name = "abbreviation-tips";
          src = myPkgs.fish-plugins.abbreviation-tips.src;
        }
      ])
      (mkIf cfgFzf.enable [
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
      ])
    ];

    interactiveShellInit = mkBefore # fish
      ''
        set -g fish_greeting
        fish_vi_key_bindings
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
