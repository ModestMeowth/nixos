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
        forge
        gsconnect
        no-overview
        user-themes
      ]);
  };

  gtk = {
    theme.name = "Dracula";
    iconTheme.name = "Dracula";
  };
}
