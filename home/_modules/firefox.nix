{lib, pkgs, ... }: {
  config.programs.firefox = lib.mkDefault {
    package = pkgs.unstable.firefox;
    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        ublock-origin
      ];
    };
  };
}
