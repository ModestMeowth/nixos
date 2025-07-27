{ pkgs, ... }: {
  security.rtkit.enable = true;
  services.pipewire.enable = true;

  environment.systemPackages = with pkgs; [ pwvucontrol unstable.wiremix ];
}
