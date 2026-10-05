{ agenix, config, pkgs, self, lib, nightfox, ... }:

let 
  user = "linucc"; 

  # The one knob for theming: terafox | nordfox | duskfox.
  # Everything else derives from it, home-manager included (which reads the
  # name back out of the palette as config.lib.stylix.colors.scheme).
  flavor = "duskfox";
in

{

  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
     agenix.darwinModules.default
  ];

  stylix = {
    enable = true;
    base16Scheme = "${nightfox}/extra/${flavor}/base16.yaml";
    opacity.terminal = 0.75;
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/kx/wallhaven-kxpk21.png";
      sha256 = "sha256-H0WV67iBDPGbuylcdnxfmsKk2qA/LIGDG13TgPDLwkc=";
    };
  };

  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = 6;
        inner.vertical = 6;
        # Leaves room for sketchybar (32px bar + margin), menu bar is hidden. The built-in
        # display keeps its notch row reserved anyway and the bar fits inside it.
        outer.top = [{ monitor.built-in = 4; } 40 ];
        outer.left = 4;
        outer.bottom = 4;
        outer.right = 4;
      };
      # Events consumed by modules/darwin/sketchybar/config/items/window_managers/aerospace.lua
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        # workspace_change only moves the highlight; focus_change refreshes icons and empty-workspace visibility
        "${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE; ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_focus_change"
      ];
      on-focus-changed = [
        "exec-and-forget ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_focus_change"
      ];
      # TODO: Annoying since it locks the workspace to the monitor, even when manually trying to move it to another monitor. I just want to set the initial monitor
      #   Wait for https://github.com/nikitabobko/AeroSpace/issues/123
      workspace-to-monitor-force-assignment = {
        # Assumes the following monitor layout:
        # 1 - the inbuild mac laptop screen left of the big screen
        # 2 - the big screen
        # 3 - the iPad underneith the big screen
        # main - stationary: big screen; on the move: inbuild laptop screen
        # "1" = "main"; Allow moving till soft-assign implemented
        # "2" = "main";
        # "3" = "main"; Allow moving till soft-assign implemented
        "4" = "main";
        "5" = "main";
        # "6" = 1;
        # "7" = 1;
        # "8" = 1; Allow moving til soft-assign implemented
        "9" = 1;
        "10" = 1;
        "Q" = 3;
        "W" = 3;
        # "E" = 3;
        # "R" = 3;
        # "T" = 3;
        "Y" = 3;
        # "P" = 3; Allow moving til soft-assign implemented
      };
      # on-window-detected = [
      #   {
      #     "if" = {
      #     # firefox
      #       app-id = "org.mozilla.firefox";
      #     };
      #     run = "move-node-to-workspace 1";
      #   }
      #   {
      #     "if" = {
      #       app-id = "org.ghostery.ghostty";
      #     };
      #     run = "move-node-to-workspace 2";
      #   }
      # ];
      mode.main.binding = {
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";
                alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
                
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";
        alt-0 = "workspace 10";
        alt-q = "workspace Q";
        alt-w = "workspace W";
        alt-e = "workspace E";
        alt-r = "workspace R";
        alt-t = "workspace T";
        alt-y = "workspace Y";
        alt-p = "workspace P";
        # alt-f = "workspace F";
        # alt-g = "workspace G";
        # alt-i = "workspace I";
        # alt-m = "workspace M";
        # alt-n = "workspace N";
        # alt-o = "workspace O";
        # alt-p = "workspace P";
        # alt-q = "workspace Q";
        # alt-r = "workspace R";
        # alt-s = "workspace S";
        # alt-t = "workspace T";
        # alt-u = "workspace U";
        # alt-v = "workspace V";
        # alt-w = "workspace W";
        # alt-x = "workspace X";
        # alt-y = "workspace Y";
        # alt-z = "workspace Z";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move-node-to-workspace
        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";
        alt-shift-0 = "move-node-to-workspace 10";
        alt-shift-q = "move-node-to-workspace Q";
        alt-shift-w = "move-node-to-workspace W";
        alt-shift-e = "move-node-to-workspace E";
        alt-shift-r = "move-node-to-workspace R";
        alt-shift-t = "move-node-to-workspace T";
        alt-shift-y = "move-node-to-workspace Y";
        alt-shift-p = "move-node-to-workspace P";
        # alt-shift-a = "move-node-to-workspace A";
        # alt-shift-b = "move-node-to-workspace B";
        # alt-shift-c = "move-node-to-workspace C";
        # alt-shift-d = "move-node-to-workspace D";
        # alt-shift-e = "move-node-to-workspace E";
        # alt-shift-f = "move-node-to-workspace F";
        # alt-shift-g = "move-node-to-workspace G";
        # alt-shift-i = "move-node-to-workspace I";
        # alt-shift-m = "move-node-to-workspace M";
        # alt-shift-n = "move-node-to-workspace N";
        # alt-shift-o = "move-node-to-workspace O";
        # alt-shift-p = "move-node-to-workspace P";
        # alt-shift-q = "move-node-to-workspace Q";
        # alt-shift-r = "move-node-to-workspace R";
        # alt-shift-s = "move-node-to-workspace S";
        # alt-shift-t = "move-node-to-workspace T";
        # alt-shift-u = "move-node-to-workspace U";
        # alt-shift-v = "move-node-to-workspace V";
        # alt-shift-w = "move-node-to-workspace W";
        # alt-shift-x = "move-node-to-workspace X";
        # alt-shift-y = "move-node-to-workspace Y";
        # alt-shift-z = "move-node-to-workspace Z";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
        alt-tab = "workspace-back-and-forth";
        # See: https://nikitabobko.github.io/AeroSpace/commands#move-workspace-to-monitor
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
        alt-shift-quote = "balance-sizes";

        alt-shift-period = "fullscreen";

        # See: https://nikitabobko.github.io/AeroSpace/commands#mode
        alt-shift-semicolon = "mode service";
      };
      mode.service.binding = {
        esc = "mode main";

        # l = [
        #   "move-workspace-to-monitor --workspace 1 'main'"
        #   "move-workspace-to-monitor --workspace 2 'main'"
        #   "move-workspace-to-monitor --workspace 3 'main'"
        #   "move-workspace-to-monitor --workspace 4 'main'"
        #   "move-workspace-to-monitor --workspace 5 'main'"
        #   "move-workspace-to-monitor --workspace 6 1"
        #   "move-workspace-to-monitor --workspace 7 1"
        #   ...
        # ];
      };
    };
  };

  services.jankyborders = {
    enable = true;
    width = 3.0;
    hidpi = true;
    style = "rounded";
    order = "above"; # https://github.com/FelixKratz/JankyBorders/issues/37
  };

  ids.gids.nixbld = 350;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ 
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # OrbStack NixOS VM as remote builder for aarch64-linux builds
    distributedBuilds = true;
    buildMachines = [{
      hostName = "nixos.orb.local";
      systems = [ "aarch64-linux" "x86_64-linux" ];
      maxJobs = 4;
      speedFactor = 1;
      sshUser = "root";
      sshKey = "/Users/linucc/.ssh/nix-builder";
      protocol = "ssh-ng";
      supportedFeatures = [ "benchmark" "big-parallel" ];
    }];
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs; [
  #   emacs-unstable
    agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
    devenv
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  astroNvim = {
    username = "linucc";
    nerdfont = "Iosevka";
    nodePackage = pkgs.nodejs;
    pythonPackage = pkgs.python3;
  };

  # launchd.user.agents.emacs.path = [ config.environment.systemPath ];
  # launchd.user.agents.emacs.serviceConfig = {
  #   KeepAlive = true;
  #   ProgramArguments = [
  #     "/bin/sh"
  #     "-c"
  #     "/bin/wait4path ${pkgs.emacs}/bin/emacs && exec ${pkgs.emacs}/bin/emacs --fg-daemon"
  #   ];
  #   StandardErrorPath = "/tmp/emacs.err.log";
  #   StandardOutPath = "/tmp/emacs.out.log";
  # };

  system = {
    primaryUser = "linucc";
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        AppleInterfaceStyle = "Dark";

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 1.0;
        "com.apple.sound.beep.feedback" = 1;
        _HIHideMenuBar = true;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
        FXPreferredViewStyle = "clmv";
      };

      loginwindow.GuestEnabled = false;

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = false;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
