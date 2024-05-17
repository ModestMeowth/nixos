{
  pkgs,
  ...
}: {
  imports = [
    ./dconf.nix
  ];

  home = {
    packages = with pkgs;
      [
        dracula-theme
        dracula-icon-theme
      ]
      ++ (with gnomeExtensions; [
        user-themes
        gsconnect
        forge
      ]);
  };

  gtk = {
    theme.name = "Dracula";
    iconTheme.name = "Dracula";
  };
}
