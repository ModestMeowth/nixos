{config, lib, pkgs, myPkgs, ...}: let
  ifGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  users.users.mm = {
    isNormalUser = true;
    uid = lib.mkForce 1001;
    description = "Modest Meowth";
    shell = pkgs.fish;

    extraGroups =
      [
        "wheel"
        "users"
      ]
      ++ ifGroupsExist [
        "gamemode"
        "network"
        "networkmanager"
        "libvirtd"
        "samba-users"
      ];

    initialHashedPassword = "$y$j9T$xgIkUu0jxDn.E27xw3HIP0$AxOebMJ322FjxN2ncCvz8g0HWhdn3Om.d9HyWyV35K0";

    openssh.authorizedKeys.keyFiles = [ myPkgs.keys.src ];
  };
}
