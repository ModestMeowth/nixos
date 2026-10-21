{ den, ... }:
{
  den.aspects.desktop =
    let
      ventoyVersion = "1.1.18";
    in
    {
      includes = [
        (den._.unfree [
          "ventoy-gtk3"
          "ventoy-qt"
        ])
        (den._.insecure [
          "ventoy-gtk3-${ventoyVersion}"
          "ventoy-qt-${ventoyVersion}"
        ])
      ];

      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = with pkgs; [
            kitty
          ];

          services.gvfs.enable = true;
        };

      homeManager =
        {
          config,
          pkgs,
          ...
        }:
        {
          home.packages = with pkgs; [
            gnome-calculator
            imv
            libnotify
            nautilus
            nautilus-open-any-terminal
            ncdu
            signal-desktop
            ventoy-full-gtk
            wiremix
            wireshark
          ];

          programs = {
            mpv = {
              enable = true;
              scripts = [
                pkgs.mpvScripts.builtins.autoload
              ]
              ++ (with pkgs.mpvScripts; [
                mpris
                thumbfast
              ]);
            };
          };

          services = {
            kdeconnect = {
              enable = true;
              indicator = true;
            };

            udiskie = {
              enable = true;
              settings.program_options = {
                file_manager = "${config.programs.ghostty.package}/bin/ghostty -e ${config.programs.yazi.package}/bin/yazi";
              };
            };
          };
        };
    };
}
