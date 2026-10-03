{
  lib,
  pkgs,
  namespace,
  config,
  ...
}:
with lib;
with lib.${namespace}; let
  cfg = config.${namespace}.services.sketchybar;
in {
  options.${namespace}.services.sketchybar = with types; {
    enable = mkEnableOption "enable sketchybar";
  };

  config = mkIf cfg.enable {
    # Use Homebrew-installed sketchybar instead of Nix package
    # Install via: brew tap FelixKratz/formulae && brew install sketchybar
    # Start service via: brew services start sketchybar

    environment.systemPackages = with pkgs; [
      sbarlua
    ];

    homebrew = {
      taps = [
        "FelixKratz/formulae"
      ];
      brews = [
        "sketchybar"
        "media-control"
      ];
    };

    # File deployment is handled by the home module
    # See: modules/home/programs/terminal/tools/sketchybar/default.nix
  };
}
