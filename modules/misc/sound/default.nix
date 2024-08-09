{
  config,
  lib,
  ...
}: {
  options.hostConfig.misc = {
    sound = lib.mkEnableOption "sound";
  };

  config = lib.mkIf config.hostConfig.misc.sound {
    security.rtkit.enable = true;

    hardware.pulseaudio.enable = lib.mkForce false;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
