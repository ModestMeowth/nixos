{
  den.aspects.printing.default = {
    nixos =
      {pkgs, ...}:
      {
        environment.systemPackages = [ pkgs.cups-pk-helper ];

        services.printing = {
          enable = true;
        };

        # security.polkt.extraConfig = ''
        #   polkt.addRule(function(action, subject) {
        #     if (action.id == "org.opensuse.cupspkhelper.mechanism.all-edit" && subject.isInGroup("wheel")) {
        #       return polkit.Result.YES;
        #     }
        #   });
        # '';
      };
  };
}
