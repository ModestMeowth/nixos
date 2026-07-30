{
  den.aspects.flatpak.nixos = {
    # nixpkgs.overlays = [
    #   (_final: prev: {
    #     flatpak = prev.flatpak.overrideAttrs (old: {
    #       patches = (old.patches or [ ]) ++ [ ./fix-pr-6721-spawn-path.patch ];
    #     });
    #   })
    # ];

    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
