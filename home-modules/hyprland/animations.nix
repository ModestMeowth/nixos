let
  curve =
    name: type: args:
    {
      _args = [
        name
        ({
          inherit type;
        } // args)
      ];
    };

  bezier =
    name: points:
    curve name "bezier" points;

  spring =
    name: args:
    curve name "spring" args;

  animation =
    leaf: speed: curve:
    {
      _args = [
        ({
          inherit leaf speed;
          enabled = true;
        } // curve)
      ];
    };
in
{
  wayland.windowManager.hyprland.settings = {
    config.animations.enabled = true;
    curve = [
      (bezier "easeOutQuint" {
        points = [ [ 0.23 1 ] [ 0.32 1 ] ];
      })
      (bezier "easeInOutCubic" {
        points = [ [ 0.65 0.05 ]  [ 0.36 1 ] ];
      })
      (bezier "linear" {
        points = [ [ 0 0 ] [ 1 1 ] ];
      })
      (bezier "almostLinear" {
        points = [ [ 0.5 0.5 ] [ 0.75 1 ] ];
      })
      (bezier "quick" {
        points = [ [ 0.15 0 ] [ 0.1 1 ] ];
      })

      (spring "easy" {
        mass = 1;
        stiffness = 71.2633;
        dampening = 15.8273644;
      })
    ];

    animation = [
      (animation "global" 10 {
        bezier = "default";
      })
      (animation "border" 5.39 {
        bezier = "easeOutQuint";
      })
      (animation "windows" 4.79 {
        spring = "easy";
      })
      (animation "windowsIn" 4.1 {
        spring = "easy";
        style = "popin 87%";
      })
      (animation "windowsOut" 1.49 {
        bezier = "linear";
        style = "popin 87%";
      })
      (animation "fadeIn" 1.73 {
        bezier = "almostLinear";
      })
      (animation "fadeOut" 1.46 {
        bezier = "almostLinear";
      })
      (animation "fade" 3.03 {
        bezier = "quick";
      })
      (animation "layers" 3.81 {
        bezier = "easeOutQuint";
      })
      (animation "layersIn" 4 {
        bezier = "easeOutQuint";
        style = "fade";
      })
      (animation "layersOut" 1.5 {
        bezier = "linear";
        style = "fade";
      })
      (animation "fadeLayersIn" 1.79 {
        bezier = "almostLinear";
      })
      (animation "fadeLayersOut" 1.39 {
        bezier = "almostLinear";
      })
      (animation "workspaces" 1.94 {
        bezier = "almostLinear";
        style = "fade";
      })
      (animation "workspacesIn" 1.21 {
        bezier = "almostLinear";
        style = "fade";
      })
      (animation "workspacesOut" 1.94 {
        bezier = "almostLinear";
        style = "fade";
      })
      (animation "zoomFactor" 7 {
        bezier = "quick";
      })
    ];
  };
}
