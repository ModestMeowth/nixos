{ config, lib, pkgs, myPkgs, ... }: with lib; let
  cfg = config.modules.shell.fish;
in
{
  imports = [
    ./fzf.nix
    ./starship.nix
    ./zellij.nix
  ];

  options.modules.shell.fish.enable = mkEnableOption "shell-fish";

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    programs.fish.plugins = with pkgs.fishPlugins; [
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "abbreviation-tips";
        src = myPkgs.fish-plugins.abbreviation-tips.src;
      }
    ];

    programs.fish.shellInit = mkBefore # fish
      ''
        set -g fish_greeting
        fish_vi_key_bindings

        if not string match -qi "vscode" $TERM_PROGRAM
          set ZELLIJ_AUTO_ATTACH true
          set ZELLIJ_AUTO_EXIT true
        end
      '';

    programs.fish.shellAbbrs = {
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
      ll = "eza lg --icons --sort=type";
      la = "eza -lag --icons --sort=type";
      tree = "eza --icons --tree";

      # zoxide
      cd = "z";
      ci = "zi";
    };

    programs.direnv.enable = true;
    programs.eza.enable = true;
    programs.zoxide.enable = true;
  };
}
