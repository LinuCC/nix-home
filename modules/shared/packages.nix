{ pkgs }:

with pkgs; [
  # General packages for development and system management
  alacritty
  # aspell
  # aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  tig
  gitui
  # ghostty - not building, using cask for now https://github.com/ghostty-org/ghostty/discussions/4786#discussioncomment-11766857
  killall
  neofetch
  nushell
  openssh
  sqlite
  wget
  zip

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  docker
  docker-compose
  colima
  opentofu
  texlive.combined.scheme-full

  # Media-related packages
  # emacs-all-the-icons-fonts
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  nerd-fonts.iosevka
  nerd-fonts.mplus
  iosevka
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs

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
  tmux
  unrar
  unzip

  # Python packages
  python3
  virtualenv

  # Music and entertainment
  spotify
  gimp
]
