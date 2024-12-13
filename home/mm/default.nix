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

      update:
        nh os switch "github:ModestMeowth/nixos" -- --refresh
    '';

  systemd.user.startServices = "sd-switch";
  modules.vscode-remote-fix.enable = true;
}
