{ user, config, pkgs, ... }:

let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome   = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome  = "${config.users.users.${user}.home}/.local/state"; in
{

#   "${xdg_configHome}/sketchybar/plugins/aerospace.sh" = {
#     executable = true;
#     text = ''
# #!/usr/bin/env bash
#
# if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
#     sketchybar --set $NAME background.drawing=on
# else
#     sketchybar --set $NAME background.drawing=off
# fi
#     '';
#   };


  
  # "${xdg_configHome}/aerospace/aerospace.toml" = {
  #   text = ''
  #     on-focus-changed = ['move-mouse window-lazy-center']
  #
  #     after-startup-command = ['exec-and-forget sketchybar']
  #
  #     exec-on-workspace-change = ['/bin/bash', '-c',
  #         'sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE'
  #     ]
  #   '';
  # };
  #
  # Raycast script so that "Run Emacs" is available and uses Emacs daemon
  # "${xdg_dataHome}/bin/emacsclient" = {
  #   executable = true;
  #   text = ''
  #     #!/bin/zsh
  #     #
  #     # Required parameters:
  #     # @raycast.schemaVersion 1
  #     # @raycast.title Run Emacs
  #     # @raycast.mode silent
  #     #
  #     # Optional parameters:
  #     # @raycast.packageName Emacs
  #     # @raycast.icon ${xdg_dataHome}/img/icons/Emacs.icns
  #     # @raycast.iconDark ${xdg_dataHome}/img/icons/Emacs.icns

  #     if [[ $1 = "-t" ]]; then
  #       # Terminal mode
  #       ${pkgs.emacs}/bin/emacsclient -t $@
  #     else
  #       # GUI mode
  #       ${pkgs.emacs}/bin/emacsclient -c -n $@
  #     fi
  #   '';
  # };
}
