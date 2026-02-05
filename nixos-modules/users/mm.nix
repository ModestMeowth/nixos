{
  config,
  lib,
  pkgs,
  ...
}:
let
  hostname = config.networking.hostName;
  ifGroupsExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  sops.secrets."mm-passwd".neededForUsers = true;
  programs.fish.enable = true;
  environment.systemPackages = with pkgs.fishPlugins; [
    fzf-fish
    puffer
  ];

  users.users."mm-${hostname}" = {
    name = "mm";
    isNormalUser = true;
    uid = lib.mkForce 1001;
    description = "Modest Meowth";
    linger = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "users"
      "input"
    ]
    ++ ifGroupsExist [
      "docker"
      "gamemode"
      "network"
      "networkmanager"
      "libvirtd"
      "samba-users"
      "wireshark"
    ];

    hashedPasswordFile = config.sops.secrets.mm-passwd.path;
  };
}
