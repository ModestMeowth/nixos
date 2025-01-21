{lib, ...}: {
  programs.ghostty = {
    enableBashIntegration = lib.mkDefault true;
    enableFishIntegration = lib.mkDefault true;
    enableZshIntegration = lib.mkDefault true;

    installBatSyntax = true;

    settings = lib.mkDefault {
      theme = "Dracula";
    };
  };
}
