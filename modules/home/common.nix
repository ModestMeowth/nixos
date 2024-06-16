{
  inputs,
  pkgs,
  ...
}: {

  imports = [
    ./git.nix
    ./fish
    ./neovim
  ];

  systemd.user.startServices = "sd-switch";

  home = {
    stateVersion = "24.05";

    packages = with pkgs; [
      just
      mosh
      ncdu
      nmap
      ripgrep
    ];
  };

  programs = {
    home-manager.enable = true;

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batman
        batdiff
        prettybat
      ];
      themes.dracula = {
        src = "${inputs.dracula.outputs.sublime}";
        file = "Dracula.tmTheme";
      };
    };
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        indent_size = 4;
      };

      "*.{yaml,nix}" = {
        indent_size = 2;
      };

      "Makefile" = {
        indent_style = "tab";
      };
    };
  };

  xdg.dataFile."bw-copy" = {
    text = /*bash*/ ''
      #!/usr/bin/env bash
      (sops -d "$HOME/secrets/bitwarden" | wl-copy && sleep 10 && wl-copy -c) &
    '';
    executable = true;
  };
}
