{lib, ...}: {
  nix.settings = {
    builders-use-substitues = lib.mkDefault true;
    max-jobs = lib.mkDefault 0;
  };
}
