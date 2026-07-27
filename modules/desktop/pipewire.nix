{
  den.aspects.desktop = {
    nixos = {
      services.pipewire.enable = true;
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          pulseaudio
          pwvucontrol
          wiremix
        ];
      };
  };
}
