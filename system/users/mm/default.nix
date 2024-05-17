{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./secrets.nix
  ];

  programs.fish.enable = true;

  users.users.mm = {
    isNormalUser = true;
    uid = lib.mkForce 1001;
    description = "Modest Meowth";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    initialHashedPassword = "$y$j9T$xgIkUu0jxDn.E27xw3HIP0$AxOebMJ322FjxN2ncCvz8g0HWhdn3Om.d9HyWyV35K0";
  };
}
