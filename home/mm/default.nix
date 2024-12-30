{ hostname, pkgs, ... }: {
  imports = [
    ../_modules
    ./hosts/${hostname}.nix
    ./shell.nix
  ];

  home = {
    stateVersion = "24.11";

    username = "mm";
    homeDirectory = "/home/mm";
    file."justfile".text = # just
      ''
        default:
          @just --choose --justfile "{{justfile()}}"

        clean:
          nh clean all

        update:
          nh os switch "github:ModestMeowth/nixos" -- --refresh
      '';

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
    neovim.enable = true;
    gh.enable = true;
  };

  systemd.user.startServices = "sd-switch";
}
