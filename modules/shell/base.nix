{
  den.default = {
    nixos = {

    };

    homeManager = {
      home = {
        sessionVariables = {
          XDG_CONFIG_HOME = "$HOME/.config";
        };

        shellAliases = {
          cat = "bat";
        };
      };

      programs.bash.enable = true;
    };
  };
}
