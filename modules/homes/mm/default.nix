{ den, inputs, lib, ...}: {
  den.aspects.mm = {
    includes = with den.aspects; [
      den._.primary-user
      (den._.user-shell "fish")

      shell.fish
      dev.helix
    ];

    homeManager =
      {
        home.file = {
          ".editorconfig".source = inputs.self + /dotfiles/editorconfig/editorconfig;
          ".local/bin/mosh" = {
            source = inputs.self + /dotfiles/bin/mosh;
            executable = true;
          };
        };

        xdg = {
          localBinInPath = true;
          configFile = {
            "tmux/tmux.conf".source = inputs.self + /dotfiles/tmux/tmux.conf;
          };
        };

        programs = {
          man.generateCaches = lib.mkForce false;

          eza = {
            colors = "auto";
            git = true;
            icons = "auto";

            extraOptions = [
              "--group-directories-first"
              "--header"
            ];
          };
        };

        services.ssh-agent.enable = true;
      };
  };
}
