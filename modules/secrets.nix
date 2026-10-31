{inputs, lib, ...}:
let
  inherit (lib) mkDefault;
  sops_config = {
    defaultSopsFile = inputs.self + /secrets/default.sops.yaml;
    age = {
      generateKey = true;
      sshKeyPaths = mkDefault [ "/persist/etc/sops/agekey" ];
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
