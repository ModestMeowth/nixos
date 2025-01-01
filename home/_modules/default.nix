{
  imports = [
    ./chromium.nix
    ./editorconfig.nix
    ./firefox.nix
    ./git.nix
    ./gnome
    ./neovim
    ./registry.nix
    ./shell
    ./virt-man.nix
    ./wezterm.nix
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
