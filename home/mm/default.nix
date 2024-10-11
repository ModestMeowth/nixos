{hostname, inputs, pkgs, username, ...}: {
  imports = [
    ./hosts/${hostname}.nix
    ./shell.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.05";

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    just
    mosh
    ncdu
    nmap
    ripgrep
  ];

  home.file."justfile".source = "${inputs.mm.outputs.dotfiles}/justfile-nixos";

  systemd.user.startServices = "sd-switch";
}
