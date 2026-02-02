{inputs, self, withSystem, ...}:
let
  lib' = import ./lib/hosts.nix {inherit inputs self withSystem; };
in
{
  flake.nixosConfigurations = {
    "rocinante" = lib'.mkHost { hostname = "rocinante"; };
    "pwnyboy" = lib'.mkHost { hostname = "pwnyboy"; };

    "videodrome" = lib'.mkHost {
      hostname = "videodrome";
      mod = with inputs; [
        wsl.nixosModules.wsl
      ];
    };

    "skinman" = lib'.mkHost {
      hostname = "skinman";
      system = "aarch64-linux";
      mod = with inputs; [
        nixos-hardware.nixosModules.raspberry-pi-4
      ];
    };

    rpi = inputs.nixpkgs.lib.nixosSystem {
      modules = [ ./nixosModules/rpi/mkimg.nix ];
    };
  };

  flake.homeConfigurations = {
    "mm@rocinante" = lib'.mkHome { hostname = "rocinante"; };
    "mm@pwnyboy" = lib'.mkHome { hostname = "pwnyboy"; };
    "mm@videodrome" = lib'.mkHome { hostname = "videodrome"; };
    "mm@skinman" = lib'.mkHome { hostname = "skinman"; system = "aarch64-linux"; };
  };
}
