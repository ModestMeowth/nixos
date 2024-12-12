{ hostname, pkgs, ... }: {
  imports = [
    ../_modules
    ./hosts/${hostname}.nix
    ./shell.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  home.username = "mm";
  home.homeDirectory = "/home/mm";

  home.packages = with pkgs; [
    just
    mosh
    ncdu
    nmap
    ripgrep
  ];

  home.file."justfile".text = # just
    ''
      default:
        @just --choose --justfile "{{ justfile() }}"

      system-update:
        nh os switch "github:ModestMeowth/nixos" -- --refresh

      home-update:
        nh home switch "github:ModestMeowth/nixos" -- --refresh

      update: system-update home-update
    '';

  systemd.user.startServices = "sd-switch";
}
