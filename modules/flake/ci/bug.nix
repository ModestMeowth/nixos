{ denTest, ... }:
{
  flake.tests.bogus = {
    test-multiple-homes-with-standalone = denTest (
      { config, den, ... }:
      {
        den.default.includes = [ den._.define-user ];

        den.hosts.x86_64-linux.igloo.users.tux = { };
        den.hosts.x86_64-linux.iceberg.users.tux = { };
        den.hosts.x86_64-linux.researchStation.users.tux = { };

        den.homes.x86_64-linux."tux@igloo" = { };
        den.homes.x86_64-linux."tux@iceberg" = { };
        den.homes.x86_64-linux."tux@researchStation" = { };

        den.aspects.tux = {
          _.igloo = { host, ... }: {
            homeManager.home.sessionVariables.HOSTNAME = host.name;
          };

          _.iceberg = { host, ... }: {
            homeManager.home.sessionVariables.HOSTNAME = host.name;
          };

          _.researchStation = { host, ... }: {
            homeManager.home.sessionVariables.HOSTNAME = host.name;
          };
        };

        expr = {
          igloo =
            config.flake.nixosConfigurations.igloo.config.home-manager.users.tux.home.sessionVariables.HOSTNAME;
          iceberg =
            config.flake.nixosConfigurations.iceberg.config.home-manager.users.tux.home.sessionVariables.HOSTNAME;
          researchStation =
            config.flake.nixosConfigurations.researchStation.config.home-manager.users.tux.home.sessionVariables.HOSTNAME;

          iglooHm = config.flake.homeConfigurations."tux@igloo".config.home.sessionVariables.HOSTNAME;
          icebergHm = config.flake.homeConfigurations."tux@iceberg".config.home.sessionVariables.HOSTNAME;
          researchStationHm =
            config.flake.homeConfigurations."tux@researchStation".config.home.sessionVariables.HOSTNAME;
        };

        expected = {
          igloo = "igloo";
          iceberg = "iceberg";
          researchStation = "researchStation";

          iglooHm = "igloo";
          icebergHm = "iceberg";
          researchStationHm = "researchStation";
        };
      }
    );
  };
}
