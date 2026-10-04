{ pkgs, config, user, nightfox, ... }:

# let
#  githubPublicKey = "ssh-ed25519 AAAA...";
# in
let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  # Read the flavor back out of the palette so there is still only one knob
  # (set in hosts/darwin/default.nix).
  flavor = config.lib.stylix.colors.scheme;
in
{

  # Upstream-authored ghostty theme for the selected flavor, referenced by
  # `theme = <flavor>` in modules/shared/home-manager.nix.
  "${xdg_configHome}/ghostty/themes/${flavor}" = {
    source = "${nightfox}/extra/${flavor}/${flavor}.ghostty";
  };

  # One file carries every nightfox flavor under `themes { ... }`, so this does
  # not need to change when the flavor does.
  "${xdg_configHome}/zellij/themes/nightfox.kdl" = {
    source = "${nightfox}/extra/zellij/nightfox.kdl";
  };

  # "${xdg_configHome}/ghostty/config" = {
  #   source = ./config/ghostty/config;
  #   recursive = true;
  # };

  "${xdg_configHome}/ghostty/shaders" = {
    source = ./config/ghostty/shaders;
    recursive = true;
  };
  ".local/bin" = {
    source = ./scripts;
    recursive = true;
  };
  # "${xdg_configHome}/nu/completions/git-completions.nu" = {
  #   text = builtins.readFile ./config/nu/git-completions.nu;
  # };
  #
  # "${xdg_configHome}/nu/completions/yarn-completions.nu" = {
  #   text = builtins.readFile ./config/nu/yarn-completions.nu;
  # };

  # ".ssh/id_github.pub" = {
  #   text = githubPublicKey;
  # };

  # Initializes Emacs with org-mode so we can tangle the main config
  # ".emacs.d/init.el" = {
  #   text = builtins.readFile ../shared/config/emacs/init.el;
  # };
}
