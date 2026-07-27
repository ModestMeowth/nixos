{ theming, ... }:
{
  den.aspects.mm = {
    includes = with theming; [
      default
      (catppuccin "mocha" "mauve")
    ];

    nixos =
      { pkgs, ... }:
      {
        theming.fonts = {
          serif = {
            name = "0xProto Nerd Font Propo";
            package = pkgs.nerd-fonts._0xproto;
          };

          sansSerif = {
            name = "Caskaydia Cove Nerd Font";
            package = pkgs.nerd-fonts.caskaydia-cove;
          };

          monospace = {
            name = "0xProto Nerd Font Mono";
            package = pkgs.nerd-fonts._0xproto;
          };

          sizes.terminal = 10;
        };
      };

    homeManager =
      { osConfig, ... }:
      {
        theming = osConfig.theming;
      };
  };
}
