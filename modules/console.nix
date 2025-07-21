{ pkgs, ... }: {
  services.kmscon = {
    enable = true;

    fonts = [
      {
        name = "0xProto Nerd Font Mono";
        package = pkgs.nerd-fonts._0xproto;
      }
    ];
  };

  stylix.targets = {
    console.enable = true;
    kmscon.enable = true;
  };
}
