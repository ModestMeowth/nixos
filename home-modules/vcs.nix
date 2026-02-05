{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
    };

    gh.enable  = true;

    jujutsu = {
      enable  = true;
      package = pkgs.unstable.jujutsu;
    };
  };
}
