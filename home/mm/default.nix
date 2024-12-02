{ hostname, pkgs, username, ... }: {
  imports = [
    ./hosts/${hostname}.nix
    ./shell.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  home.username = username;
  home.homeDirectory = "/home/${username}";

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
