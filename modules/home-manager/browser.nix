{ pkgs, ... }: {
  programs.firefox = {
    package = pkgs.unstable.firefox;
    profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      ublock-origin
    ];
  };
}
