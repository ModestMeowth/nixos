{ den, inputs, ... }: {
  den.aspects.mm = {
    includes = [
      den._.primary-user
      (den._.user-shell "fish")
      den.aspects.shell
      den.aspects.shell._.fish
      den.aspects.dev
      den.aspects.dev._.helix
    ];

    nixos =
      { config, lib, ... }:
      let
        ifGroupExists = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
      in
      {
        users.users.mm = {
          description = "Modest Meowth";
          linger = true;
          uid = lib.mkForce 1001;
          extraGroups = [
            "cdrom"
            "input"
            "video"
          ]
          ++ ifGroupExists [
            "docker"
            "gamemode"
            "libvirtd"
            "network"
            "networkmanager"
            "podman"
            "samba-users"
            "wireshark"
          ];
        };

        services.displayManager.autoLogin = {
          enable = true;
          user = "mm";
        };
      };

    homeManager =
      {lib, ...}:
      {
        home.file = {
          ".editorconfig".source = inputs.self + /dotfiles/editorconfig/editorconfig;
          ".local/bin/mosh" = {
            source = inputs.self + /dotfiles/bin/mosh;
            executable = true;
          };
        };

        xdg.configFile = {
          "tmux/tmux.conf".source = inputs.self + /dotfiles/tmux/tmux.conf;
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
