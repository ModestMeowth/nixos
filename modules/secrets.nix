{
  inputs,
  lib,
  ...
}:
let
  sops_config = {
    defaultSopsFile = inputs.self + /secrets.sops.yaml;
    age = {
      generateKey = true;
      sshKeyPaths = lib.mkDefault [ "/persist/etc/sops/agekey" ];
    };
  };
in
{
  den.default = {
    nixos = {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = sops_config;
    };

    homeManager =
      { pkgs, ... }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        home.packages = [ pkgs.sops ];
        sops = sops_config;
      };
  };
}
