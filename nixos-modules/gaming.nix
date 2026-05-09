let
in
{
  programs = {
    gamemode = {
      enable = true;
      settings.general = {
        desiredgov = "performance";
        inhibit_screensaver = 1;
      };
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
