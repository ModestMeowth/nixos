{
  den.schema.host =
    {lib, ...}:
    let
      inherit (lib) mkEnableOption;
    in
    {
      options.hw.gpu = {
        amd = mkEnableOption "amd gpu";
        intel = mkEnableOption "intel gpu";
        nvidia = mkEnableOption "nvidia gpu";
      };
    };
}
