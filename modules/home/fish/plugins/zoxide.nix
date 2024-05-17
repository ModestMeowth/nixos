{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
  };

  programs.fish.shellAbbrs = {
    cd = "z";
    ci = "zi";
  };
}
