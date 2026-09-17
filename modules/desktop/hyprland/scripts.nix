{ lib, ... }:
{
  den.aspects.desktop._.hyprland = {
    homeManager =
      { pkgs, ... }:
      let
        inherit (lib) mergeAttrsList;
        mkBinFile =
          binDir:
          {
            source,
            target ? source,
          }:
          {
            "${binDir}/${target}" = {
              source = ../../../dotfiles/bin/${source};
              executable = true;
            };
          };
        mkBinFiles = binDir: list: mergeAttrsList (map (f: (mkBinFile binDir { source = f; })) list);
      in
      {
        programs.jq.enable = true;

        home = {
          file = mkBinFiles ".local/bin" [
            "hyprland-window-close-all"
            "hyprland-window-pop"
            "hyprland-workspace-toggle-gaps"
            "hyprland-focused-monitor"

            "hyprscope"

            "launch-or-focus"
            "launch-tui"
            "launch-or-focus-tui"

            "launch-browser"
            "launch-calculator"
            "launch-editor"
            "launch-file-manager"
            "launch-password-manager"
            "launch-screensaver"
            "launch-sysmon"
          ];
        };
      };
  };
}
