{ pkgs, config, user, ... }:

# let
#  githubPublicKey = "ssh-ed25519 AAAA...";
# in
let
  xdg_configHome = "${config.users.users.${user}.home}/.config"; in
{

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
