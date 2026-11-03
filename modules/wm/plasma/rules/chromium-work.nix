{
  den.aspects.wm.plasma = {
    homeManager = {
      programs.plasma.window-rules = [
        {
          description = "chromium-work";
          match.window-class = {
            value = "chromium-browser-work";
            match-whole = false;
          };
          apply = {
            desktops = "Desktop_2";
          };
        }
      ];
    };
  };
}
