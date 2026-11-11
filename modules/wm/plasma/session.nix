{
  den.aspects.wm.plasma = {
    homeManager =
      {lib, ...}:
      let
        inherit (lib) mkDefault;
      in
      {
        programs.plasma = {
          kscreenlocker = {
            lockOnResume = mkDefault true;
            timeout = mkDefault 15;
          };

          shortcuts.ksmserver."Lock Session" = mkDefault [ "Meta+Shift+Del" ]; # Meta+L
          session.sessionRestore.restoreOpenApplicationsOnLogin = mkDefault "whenSessionWasManuallySaved";
        };
      };
  };
}
