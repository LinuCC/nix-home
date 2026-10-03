_:

let
  mkGreedy = caskName: { name = caskName; greedy = true; };
in map mkGreedy [
  # Development Tools
  # "homebrew/cask/docker"
  # "docker-desktop"
  "visual-studio-code"
  # TODO: Try out building the Nix package once its not bleeding edge anymore
  "ghostty"
  "wine-stable"

  # Communication Tools
  # "discord"
  # "slack"
  "microsoft-teams"

  # Utility Tools
  "bitwarden"
  "1password"
  # "alfred"
  "istat-menus"
  "proton-mail-bridge"
  "tunnelblick"
  # "betterdisplay"
  # "parallels" # Does not work right now, manually installed

  # Entertainment Tools
  "font-sketchybar-app-font"

  # Productivity Tools
  "raycast"

  # Browsers
  "ungoogled-chromium"
    # "chromium"
  "firefox"
  # "orion"
]
