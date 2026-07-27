{ den, ... }: {
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

    homeManager = { };
  };

}
