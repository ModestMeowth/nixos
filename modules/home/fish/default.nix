{pkgs, ...}: {
  imports = [
    ./plugins
  ];

  programs.fish = {
    enable = true;

    plugins = with pkgs.fishPlugins; [
      {
        name = "puffer";
        src = puffer.src;
      }
    ];

    interactiveShellInit = /*fish*/ ''
      set -g fish_greeting
      fish_vi_key_bindings
    '';

    shellAbbrs = {
      ssh = "mosh";
      g = "git";
      ga = "git add";
      clone = "git clone";
      co = "git checkout";
      cz = "git cz c";
    };
  };
}
