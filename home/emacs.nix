{ config, lib, pkgs, ... }:
let HOME = config.home.homeDirectory;
in {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = p:
      with p; [
        doom
        pdf-tools
        org-roam
        treesit-grammars.with-all-grammars
        vterm
      ];
  };

  services.emacs.enable = true;
  systemd.user.services.emacs.Service = lib.mkForce {
    Environment = [
      "DOOMDIR=${HOME}/.config/doom"
      "DOOMLOCALDIR=${HOME}/.local/share/doom"
    ];

    ExecStart = "${HOME}/.emacs.d/bin/doom emacs --fg-daemon";
    Type = "simple";
  };

  home.activation.installDoomEmacs =
    config.lib.dag.entryAfter [ "writeBoundry" ] # bash
    ''
      if [ ! -d "${HOME}/.emacs.d" ]; then
        echo "Installing Doom Emacs..."
        ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ${HOME}/.emacs.d

        export PATH="${pkgs.emacs}/bin:${pkgs.git}/bin:${pkgs.ripgrep}/bin:${pkgs.fd}/bin:$PATH"

        if [ -x "${HOME}/.emacs.d/bin/doom" ]; then
          echo "Running doom install..."
          ${HOME}/.emacs.d/bin/doom install --no-env --no-hooks
        else
          echo "Error: doom binary not found after clone"
          exit 1
        fi
      else
        echo "Doom emacs already installed"
      fi
    '';

  home.activation.syncDoomEmacs =
    config.lib.dag.entryAfter [ "linkGeneration" "installDoomEmacs" ] # bash
    ''
      if [ -d "${HOME}/.emacs.d" ] && [ -d "${HOME}/.config/doom" ]; then
        if [  -x "${HOME}/.emacs.d/bin/doom" ]; then
          echo "Syncing Doom configuration"
          export PATH="${pkgs.emacs}/bin:${pkgs.git}/bin:${pkgs.ripgrep}/bin:${pkgs.fd}/bin:$PATH"
          ${HOME}/.emacs.d/bin/doom sync
        else
          echo "Warning doom binary not found, skipping sync"
        fi
      else
        echo "Warning doom config not found, skipping sync"
      fi
    '';

  home.sessionPath = [ "${HOME}/.emacs.d/bin" ];
  home.sessionVariables = {
    DOOMDIR = "${HOME}/.config/doom";
    DOOMLOCALDIR = "${HOME}/.local/share/doom";
  };
}
