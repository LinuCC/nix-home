{ pkgs }:
with pkgs;
let 
  # old-spotify = pkgs.spotify.overrideAttrs (oldAttrs: {
  #   src =
  #     if (pkgs.stdenv.isDarwin && pkgs.stdenv.isAarch64) then
  #       pkgs.fetchurl {
  #         url = "https://web.archive.org/web/20251029235406/https://download.scdn.co/SpotifyARM64.dmg";
  #         hash = "sha256-0gwoptqLBJBM0qJQ+dGAZdCD6WXzDJEs0BfOxz7f2nQ=";
  #       }
  #     else
  #       oldAttrs.src;
  # });
  appSupport = "/Users/linucc/Library/Application Support";
  # macOS 27 restricts ~/Library/Application Support/<App> to Mozilla-signed
  # builds; nixpkgs browsers are unsigned, so relocate the datadir.
  relocateDataDir = name: drv:
    if pkgs.stdenv.isDarwin
    then drv.override { appDataDir = "${appSupport}/${name}"; }
    else drv;
in [
# [
  # General packages for development and system management
  alacritty
  # aider-chat-full
  # goose-cli
  # aspell
  # aspellDicts.en
  bash-completion
  coreutils
  # devenv - installed in darwin config (nixpkgs pkgs.devenv)
  jetbrains-toolbox
  # jdk
  # jetbrains.jdk
  opencode
  claude-code
  tig
  jujutsu
  # gitui
  # ghostty - not building, using cask for now https://github.com/ghostty-org/ghostty/discussions/4786#discussioncomment-11766857
  killall
  fastfetch
  nushell
  openssh
  # oxker
  sqlite
  wget
  zip
  wireguard-go
  wireguard-tools
  mqttui

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  ansible
  # colmena
  # colima
  # lima-additional-guestagents
  opentofu
  # texlive.combined.scheme-full

  # Media-related packages
  # emacs-all-the-icons-fonts
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  nerd-fonts.iosevka
  nerd-fonts."m+"
  # iosevka
  hack-font
  noto-fonts
  noto-fonts-color-emoji
  nerd-fonts.terminess-ttf
  terminus_font
  scientifica
  meslo-lgs-nf

  # Node.js development tools
  # nodePackages.npm # globally install npm
  # nodePackages.prettier

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  neovim
  obsidian
  ripgrep
  tree
  # tmux
  unrar
  unzip
  nodejs

  # Python packages
  python3
  virtualenv

  # Music and entertainment
  discord
  slack
  # (relocateDataDir "org.nixos.firefox" firefox)
  # (relocateDataDir "org.nixos.librewolf" librewolf)
  transmission_4-qt
  # chromium

  yt-dlp
]
