{
  description = "Starter Configuration with secrets for MacOS and NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/6e76ab58ba9f30f77f8276a7474cea9d2d8956fd.tar.gz";
    # fixedNushellPkgs.url = "https://github.com/NixOS/nixpkgs/archive/6e76ab58ba9f30f77f8276a7474cea9d2d8956fd.tar.gz";
    # fixedNushellPkgs = {
    #   url = "https://github.com/NixOS/nixpkgs/archive/6e76ab58ba9f30f77f8276a7474cea9d2d8956fd.tar.gz";
    #   sha256 = "sha256:1j35y9r955ya9hamwwq7hgz7v94ky9x4d954hy6xxhx59bzd09j9";
    # };
    agenix.url = "github:ryantm/agenix";
    home-manager.url = "github:nix-community/home-manager";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # colmena.url = "github:zhaofengli/colmena";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jj-starship.url = "github:dmmulroy/jj-starship";
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    }; 
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astro-nvim = {
      # url = "github:LinuCC/dotvim/main";
      url = "git+file:///Users/linucc/code/nix/astro-nvim/?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Upstream nightfox ships per-flavor exports under extra/<flavor>/:
    # base16.yaml (stylix scheme), <flavor>.ghostty, <flavor>.nu, and one
    # extra/zellij/nightfox.kdl holding every flavor.
    nightfox = {
      url = "github:EdenEast/nightfox.nvim";
      flake = false;
    };
    # secrets = {
    #   url = "git+ssh://git@github.com/linucc/nix-secrets.git";
    #   flake = false;
    # };
  };
  outputs = { self, darwin, nix-homebrew, homebrew-bundle, homebrew-core, homebrew-cask, home-manager, jj-starship, nixpkgs, disko, agenix, astro-nvim, stylix, nightfox } @inputs:
    let
      user = "linucc";
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
      devShell = system: let pkgs = nixpkgs.legacyPackages.${system}; in {
        default = with pkgs; mkShell {
          nativeBuildInputs = with pkgs; [ bashInteractive git age age-plugin-yubikey ];
          shellHook = ''
            export EDITOR=vim
          '';
        };
      };
      mkApp = scriptName: system: {
        type = "app";
        program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/apps/${system}/${scriptName}
        '')}/bin/${scriptName}";
      };
      mkLinuxApps = system: {
        "apply" = mkApp "apply" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "install" = mkApp "install" system;
        # "install-with-secrets" = mkApp "install-with-secrets" system;
      };
      mkDarwinApps = system: {
        "apply" = mkApp "apply" system;
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "rollback" = mkApp "rollback" system;
      };
    in
    {
      devShells = forAllSystems devShell;
      apps = nixpkgs.lib.genAttrs linuxSystems mkLinuxApps // nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:
        darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            astro-nvim.darwinModules.astroNvim
            stylix.darwinModules.stylix
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ({pkgs, ...}: {
              nixpkgs.overlays = [ jj-starship.overlays.default ];
              environment.systemPackages = [ pkgs.jj-starship ];
            })
            ./hosts/darwin
          ];
        }
      );

      nixosConfigurations = nixpkgs.lib.genAttrs linuxSystems (system: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          disko.nixosModules.disko
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # modules/nixos/home-manager.nix is imported as an HM module, so it
              # gets HM's module args rather than specialArgs — forward the flake
              # inputs so `nightfox` resolves there too.
              extraSpecialArgs = inputs;
              users.${user} = import ./modules/nixos/home-manager.nix;
            };
          }
          ./hosts/nixos
        ];
     });
  };
}
