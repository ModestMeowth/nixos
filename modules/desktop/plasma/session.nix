{
  den.aspects.desktop._.plasma = {
    homeManager =
      {lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          shortcuts.ksmserver."Lock Screen" = mkDefault [ "Meta+Shift+L" ]; # Meta+L
          session.sessionRestore.restoreOpenApplicationsOnLogin = mkDefault "whenSessionWasManuallySaved";
        };
      };
  };
}
