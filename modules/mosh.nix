{ pkgs, ... }: let
  mosh = pkgs.mosh.overrideAttrs (oldAttrs: {
    postInstall = oldAttrs.postInstall + ''
      wrapProgram $out/bin/mosh-server \
        --set LOCALE_ARCHIVE "${pkgs.glibcLocales}/lib/locale/locale-archive"
    '';
  });
in {
  enviromnent.sytstemPackages = [
    mosh
  ];
}
