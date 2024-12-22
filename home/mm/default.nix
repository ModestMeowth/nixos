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

  programs.neovim.enable = true;
  programs.gh.enable = true;

  systemd.user.startServices = "sd-switch";
}
