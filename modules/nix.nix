{ inputs, ... }:
{
  den.default = {
    nixos = {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];

      programs = {
        command-not-found.enable = false;
        nix-index-database.comma.enable = true;
      };

      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          keep-outputs = true;
          keep-derivations = true;

          substituters = [
            "http://pwnyboy:8501"
          ];

          trusted-public-keys = [
            "pwnyboy:QCpL6GVuYQ/SAsvrelgXV5GkZnWc/fvoKnp9Ha2i3XA="
          ];

          trusted-users = [
            "root"
            "@wheel"
          ];
          use-xdg-base-directories = true;
        };
      };
    };
  };
}
