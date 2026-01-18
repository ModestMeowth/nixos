{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    unstable.url = "nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixdb.url = "github:nix-community/nix-index-database";

    sops-nix.url = "sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wsl.url = "github:nix-community/NixOS-WSL/release-25.11";
    wsl.inputs.nixpkgs.follows = "nixpkgs";
    wsl.inputs.flake-compat.follows = "";

    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:nix-community/stylix/release-25.11";
  };

  outputs =
    { flake-parts, ...} @ inputs:
    let
      mkPkgs = {
          system ? "x86_64-linux"
        , additionalConfig ? { }
        , additionalOverlays ? []
      }:
        import inputs.nixpkgs {
          system = system;
          config = { allowUnfree = true; } // additionalConfig;
          overlays = [
              (final: _: {
                unstable = import inputs.unstable {
                  system = system;
                  config = { allowUnfree = true; } // additionalConfig;
                  overlays = additionalOverlays;
                };
              })
            ] ++ additionalOverlays;
        };

      customLib = import ./lib { inherit inputs mkPkgs; };
    in
    with customLib; flake-parts.lib.mkFlake { inherit inputs; }
    {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem =
      { pkgs, ... }:
      {
          formatter = pkgs.nixfmt;
      };

      flake.nixosConfigurations = {
        "rocinante" = mkHost {
          hostname = "rocinante";
          additionalConfig = { rocmSupport = true; };
          additionalModules = with inputs; [
            lanzaboote.nixosModules.lanzaboote
            stylix.nixosModules.stylix
            ./modules/shared/physical
            ./modules/desktop
            ./modules/gaming
          ];
        };

        "pwnyboy" = mkHost {
          hostname = "pwnyboy";
          additionalModules = with inputs; [
            lanzaboote.nixosModules.lanzaboote
            ./modules/shared/physical
          ];
        };

        "videodrome" = mkHost {
          hostname = "videodrome";
          additionalConfig = { cudaSupport = true; };
          additionalModules = with inputs; [
            wsl.nixosModules.default
            ./modules/shared/virtual/wsl.nix
          ];
        };
      };

      flake.homeConfigurations = {
        "mm@rocinante" = mkHome {
            hostname = "rocinante";
            additionalOverlays = [
              (self: super: {
                google-chrome = super.google-chrome.override {
                  commandLineArgs = [
                    "--enable-features=VaapiVideoDecodeLinuxGLVaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
                  ];
                };
              })
            ];
        };
        "mm@pwnyboy" = mkHome { hostname = "pwnyboy";};
        "mm@videodrome" = mkHome { hostname = "videodrome"; };
      };
    };
}
