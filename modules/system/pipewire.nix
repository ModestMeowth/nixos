{
  pkgs,
  lib,
  ...
}: {
  security.rtkit.enable = true;

  hardware.pulseaudio.enable = lib.mkForce false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
