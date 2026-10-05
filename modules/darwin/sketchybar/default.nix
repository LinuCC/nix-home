{ pkgs, config, lib, ... }:

let
  c = config.lib.stylix.colors;
  argb = name: "0xff${c.${name}}";

  # Upstream items reference Catppuccin color names. Map them onto base16 by
  # role rather than by the usual catppuccin<->base16 table: in nightfox's
  # schemes base07 is near-white, which would turn every focus border white.
  palette = {
    # Backgrounds
    base = "base00";
    mantle = "base01";
    crust = "base00";
    surface0 = "base02";
    surface1 = "base03";
    surface2 = "base03";
    # Dimmed foregrounds, used for inactive icons and labels
    overlay0 = "base04";
    overlay1 = "base04";
    overlay2 = "base06";
    subtext0 = "base06";
    subtext1 = "base06";
    text = "base05";
    # Accents; lavender is the focus color, mauve the secondary highlight
    lavender = "base0E";
    mauve = "base0D";
    rosewater = "base06";
    flamingo = "base0F";
    pink = "base0F";
    red = "base08";
    maroon = "base08";
    peach = "base09";
    yellow = "base0A";
    green = "base0B";
    teal = "base0C";
    sky = "base0C";
    sapphire = "base0D";
    blue = "base0D";
  };
in
{
  # Vendored from https://github.com/phucisstupid/sketchybar-config at 6285d8a; overrides
  # live in ./config/settings.lua. Local patches on top of upstream:
  # - items/window_managers/aerospace.lua: register the aerospace events before subscribing
  # - items/window_managers/*.lua: icon_map v3 names the fallback 'Default', not 'default'
  # - items/right/volume.lua: tonumber() got gsub's match count as its base argument
  # - init.lua, items/music: separate music.bar_title_max_length for the title in the bar
  # - items/music: slower title scroll
  # - items/music: skip the cover when the source has no artwork, show a same-size placeholder
  programs.sketchybar = {
    enable = true;
    configType = "lua";
    config = {
      source = ./config;
      recursive = true;
    };
    # Tools the lua items shell out to; media-control comes from brew
    extraPackages = with pkgs; [ aerospace jq switchaudio-osx ];
    service.enable = true;
  };

  xdg.configFile = {
    # Not shipped in the config repo; take it from the same package that installs the font so they match
    "sketchybar/helpers/spaces_util/icon_map.lua".source =
      "${pkgs.sketchybar-app-font}/lib/sketchybar-app-font/icon_map.lua";

    # Replaces upstream's hardcoded Catppuccin Mocha palette with the stylix scheme
    "sketchybar/colors.lua".text = ''
      -- Generated from the stylix ${c.scheme} scheme, see modules/darwin/sketchybar/default.nix
      return {
      ${lib.concatStrings (lib.mapAttrsToList (name: base: "  ${name} = ${argb base},\n") palette)}
        transparent = 0x00000000,

        with_alpha = function(color, alpha)
          if alpha > 1.0 or alpha < 0.0 then
            return color
          end
          return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
        end,
      }
    '';
  };

  # launchd keeps the old sketchybar running across switches; restart so config changes apply
  home.activation.restartSketchybar = lib.hm.dag.entryAfter [ "setupLaunchAgents" ] ''
    run /bin/launchctl kickstart -k "gui/$(/usr/bin/id -u)/org.nix-community.home.sketchybar" || true
  '';
}
