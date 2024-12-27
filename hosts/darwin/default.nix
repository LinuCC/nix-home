{ agenix, config, pkgs, ... }:

let 
  user = "linucc"; 
  sketchybar-aerospace-window-plugin = pkgs.writeScript "sketchybar-aerospace-window-plugin.sh" ''
    #!/usr/bin/env bash

    if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
        sketchybar --set $1 background.drawing=on
    else
        sketchybar --set $1 background.drawing=off
    fi
  '';

  sketchybar-colors = pkgs.writeScript "sketchybar-colors.sh" ''
    #!/bin/bash

    export ROSEWATER=0xFF2E3440 #2E3440
    export FLAMINGO=0xFF3B4252 #3B4252
    export PINK=0xFF434C5E #434C5E
    export MAUVE=0xFF4C566A #4C566A
    export RED=0xFFBF616A #BF616A
    export MAROON=0xFFD08770 #D08770
    export PEACH=0xFFEBCB8B #EBCB8B
    export YELLOW=0xFFA3BE8C #A3BE8C
    export GREEN=0xFF8FBCBB #8FBCBB
    export TEAL=0xFF88C0D0 #88C0D0
    export SKY=0xFF81A1C1 #81A1C1
    export SAPPHIRE=0xFF5E81AC #5E81AC
    export BLUE=0xFFD8DEE9 #D8DEE9
    export LAVENDER=0xFFB48EAD #B48EAD

    export WHITE=0xFFECEFF4 #ECEFF4
    export DARK_WHITE=0xFFE5E9F0 #E5E9F0

    export BG_PRI_COLR=0xFF2E3440 #2E3440
    export BG_SEC_COLR=0xFF3B4252 #3B4252
  '';

  sketchybar-icons = pkgs.writeScript "sketchybar-icons.sh" ''
    #!/bin/bash

    export BATTERY_BOLT_ICON=󰂄
    export BATTERY_100_ICON=󰂂
    export BATTERY_75_ICON=󰂁
    export BATTERY_50_ICON=󰁾
    export BATTERY_25_ICON=󰁽
    export BATTERY_0_ICON=

    export APPLE_ICON=

    export WIFI_CONN_ICON=

    export SOUND_FUL_ICON=
    export SOUND_HIG_ICON=
    export SOUND_MID_ICON=
    export SOUND_LOW_ICON=
    export SOUND_MUT_ICON=
  '';

  sketchybar-plugin-battery = pkgs.writeScript "sketchybar-plugin-battery.sh" ''
    #!/bin/bash

    source "${sketchybar-icons}"

    PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    CHARGING=$(pmset -g batt | grep 'AC Power')

    if [ $PERCENTAGE = "" ]; then
      exit 0
    fi

    case ''${PERCENTAGE} in
      9[0-9]|100) ICON="$BATTERY_100_ICON" ;;
      [6-8][0-9]) ICON="$BATTERY_75_ICON" ;;
      [3-5][0-9]) ICON="$BATTERY_50_ICON" ;;
      [1-2][0-9]) ICON="$BATTERY_25_ICON" ;;
      *) ICON="$BATTERY_0_ICON"
    esac

    if [[ $CHARGING != "" ]]; then
      ICON="$BATTERY_BOLT_ICON"
    fi

    sketchybar --set $NAME icon="$ICON" label="''${PERCENTAGE}%"
  '';

  sketchybar-plugin-cpu = pkgs.writeScript "sketchybar-plugin-cpu.sh" ''
    #!/bin/bash

    CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
    CPU_INFO=$(ps -eo pcpu,user)
    CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
    CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

    CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

    sketchybar --set $NAME label="$CPU_PERCENT%"
    '';

    sketchybar-plugin-front-app = pkgs.writeScript "sketchybar-plugin-front-app.sh" ''
    #!/bin/sh

    # Some events send additional information specific to the event in the $INFO
    # variable. E.g. the front_app_switched event sends the name of the newly
    # focused application in the $INFO variable:
    # https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

    if [ "$SENDER" = "front_app_switched" ]; then
      sketchybar --set $NAME label="$INFO" icon="$(${sketchybar-icon-map-fn} "$INFO")"
    fi
  '';

  sketchybar-icon-map-fn = pkgs.writeScript "sketchybar-icon-map-fn.sh" ''
    function icon_map() {
      case "$1" in
      "Keynote" | "Keynote 讲演")
        icon_result=":keynote:"
        ;;
      "Figma")
        icon_result=":figma:"
        ;;
      "VMware Fusion")
        icon_result=":vmware_fusion:"
        ;;
      "Alacritty" | "Hyper" | "iTerm2" | "kitty" | "Terminal" | "终端" | "WezTerm")
        icon_result=":terminal:"
        ;;
      "Microsoft To Do" | "Things")
        icon_result=":things:"
        ;;
      "Keyboard Maestro")
        icon_result=":keyboard_maestro:"
        ;;
      "App Store")
        icon_result=":app_store:"
        ;;
      "CleanMyMac X")
        icon_result=":desktop:"
        ;;
      "Android Messages")
        icon_result=":android_messages:"
        ;;
      "Reeder")
        icon_result=":reeder5:"
        ;;
      "Joplin")
        icon_result=":joplin:"
        ;;
      "Discord" | "Discord Canary" | "Discord PTB")
        icon_result=":discord:"
        ;;
      "Logseq")
        icon_result=":logseq:"
        ;;
      "Microsoft Excel")
        icon_result=":microsoft_excel:"
        ;;
      "Microsoft PowerPoint")
        icon_result=":microsoft_power_point:"
        ;;
      "Telegram")
        icon_result=":telegram:"
        ;;
      "Transmit")
        icon_result=":transmit:"
        ;;
      "Pi-hole Remote")
        icon_result=":pihole:"
        ;;
      "League of Legends")
        icon_result=":league_of_legends:"
        ;;
      "Element")
        icon_result=":element:"
        ;;
      "Zulip")
        icon_result=":zulip:"
        ;;
      "Sequel Ace")
        icon_result=":sequel_ace:"
        ;;
      "Zed")
        icon_result=":zed:"
        ;;
      "TeamSpeak 3")
        icon_result=":team_speak:"
        ;;
      "1Password")
        icon_result=":one_password:"
        ;;
      "Caprine")
        icon_result=":caprine:"
        ;;
      "카카오톡")
        icon_result=":kakaotalk:"
        ;;
      "Dropbox")
        icon_result=":dropbox:"
        ;;
      "Kakoune")
        icon_result=":kakoune:"
        ;;
      "Rider" | "JetBrains Rider")
        icon_result=":rider:"
        ;;
      "Godot")
        icon_result=":godot:"
        ;;
      "qutebrowser")
        icon_result=":qute_browser:"
        ;;
      "Typora")
        icon_result=":text:"
        ;;
      "Sequel Pro")
        icon_result=":sequel_pro:"
        ;;
      "Reminders" | "提醒事项")
        icon_result=":reminders:"
        ;;
      "Setapp")
        icon_result=":setapp:"
        ;;
      "Finder" | "访达")
        icon_result=":finder:"
        ;;
      "Matlab")
        icon_result=":matlab:"
        ;;
      "LibreWolf")
        icon_result=":libre_wolf:"
        ;;
      "Notes" | "备忘录")
        icon_result=":notes:"
        ;;
      "Notion")
        icon_result=":notion:"
        ;;
      "Brave Browser")
        icon_result=":brave_browser:"
        ;;
      "Spotlight")
        icon_result=":spotlight:"
        ;;
      "Iris")
        icon_result=":iris:"
        ;;
      "Tower")
        icon_result=":tower:"
        ;;
      "Jellyfin Media Player")
        icon_result=":jellyfin:"
        ;;
      "Code" | "Code - Insiders")
        icon_result=":code:"
        ;;
      "Linear")
        icon_result=":linear:"
        ;;
      "Live")
        icon_result=":ableton:"
        ;;
      "Parallels Desktop")
        icon_result=":parallels:"
        ;;
      "Final Cut Pro")
        icon_result=":final_cut_pro:"
        ;;
      "Chromium" | "Google Chrome" | "Google Chrome Canary")
        icon_result=":google_chrome:"
        ;;
      "GitHub Desktop")
        icon_result=":git_hub:"
        ;;
      "Firefox")
        icon_result=":firefox:"
        ;;
      "Slack")
        icon_result=":slack:"
        ;;
      "Spotify")
        icon_result=":spotify:"
        ;;
      "Neovide" | "MacVim" | "Vim" | "VimR")
        icon_result=":vim:"
        ;;
      "KeePassXC")
        icon_result=":kee_pass_x_c:"
        ;;
      "PomoDone App")
        icon_result=":pomodone:"
        ;;
      "DEVONthink 3")
        icon_result=":devonthink3:"
        ;;
      "Color Picker" | "数码测色计")
        icon_result=":color_picker:"
        ;;
      "Tweetbot" | "Twitter")
        icon_result=":twitter:"
        ;;
      "Default")
        icon_result=":default:"
        ;;
      "Pages" | "Pages 文稿")
        icon_result=":pages:"
        ;;
      "Emacs")
        icon_result=":emacs:"
        ;;
      "MAMP" | "MAMP PRO")
        icon_result=":mamp:"
        ;;
      "Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "邮件")
        icon_result=":mail:"
        ;;
      "WebStorm")
        icon_result=":web_storm:"
        ;;
      "TickTick")
        icon_result=":tick_tick:"
        ;;
      "TIDAL")
        icon_result=":tidal:"
        ;;
      "VLC")
        icon_result=":vlc:"
        ;;
      "Blender")
        icon_result=":blender:"
        ;;
      "Music" | "音乐")
        icon_result=":music:"
        ;;
      "Calendar" | "日历" | "Fantastical" | "Cron" | "Amie")
        icon_result=":calendar:"
        ;;
      "Evernote Legacy")
        icon_result=":evernote_legacy:"
        ;;
      "Microsoft Word")
        icon_result=":microsoft_word:"
        ;;
      "Safari" | "Safari浏览器" | "Safari Technology Preview")
        icon_result=":safari:"
        ;;
      "MoneyMoney")
        icon_result=":bank:"
        ;;
      "Xcode")
        icon_result=":xcode:"
        ;;
      "Numbers" | "Numbers 表格")
        icon_result=":numbers:"
        ;;
      "ClickUp")
        icon_result=":click_up:"
        ;;
      "Arc")
        icon_result=":arc:"
        ;;
      "Zeplin")
        icon_result=":zeplin:"
        ;;
      "Trello")
        icon_result=":trello:"
        ;;
      "Vivaldi")
        icon_result=":vivaldi:"
        ;;
      "Calibre")
        icon_result=":book:"
        ;;
      "Min")
        icon_result=":min_browser:"
        ;;
      "网易云音乐")
        icon_result=":netease_music:"
        ;;
      "GrandTotal" | "Receipts")
        icon_result=":dollar:"
        ;;
      "zoom.us")
        icon_result=":zoom:"
        ;;
      "Folx")
        icon_result=":folx:"
        ;;
      "微信")
        icon_result=":wechat:"
        ;;
      "Orion" | "Orion RC")
        icon_result=":orion:"
        ;;
      "Notability")
        icon_result=":notability:"
        ;;
      "Todoist")
        icon_result=":todoist:"
        ;;
      "Replit")
        icon_result=":replit:"
        ;;
      "Tor Browser")
        icon_result=":tor_browser:"
        ;;
      "Drafts")
        icon_result=":drafts:"
        ;;
      "Preview" | "预览" | "Skim" | "zathura")
        icon_result=":pdf:"
        ;;
      "PyCharm")
        icon_result=":pycharm:"
        ;;
      "Audacity")
        icon_result=":audacity:"
        ;;
      "Cypress")
        icon_result=":cypress:"
        ;;
      "VSCodium")
        icon_result=":vscodium:"
        ;;
      "Podcasts" | "播客")
        icon_result=":podcasts:"
        ;;
      "DingTalk" | "钉钉" | "阿里钉")
        icon_result=":dingtalk:"
        ;;
      "OBS")
        icon_result=":obsstudio:"
        ;;
      "Firefox Developer Edition" | "Firefox Nightly")
        icon_result=":firefox_developer_edition:"
        ;;
      "Alfred")
        icon_result=":alfred:"
        ;;
      "OmniFocus")
        icon_result=":omni_focus:"
        ;;
      "Skype")
        icon_result=":skype:"
        ;;
      "Spark Desktop")
        icon_result=":spark:"
        ;;
      "Docker" | "Docker Desktop")
        icon_result=":docker:"
        ;;
      "Signal")
        icon_result=":signal:"
        ;;
      "Pine")
        icon_result=":pine:"
        ;;
      "Insomnia")
        icon_result=":insomnia:"
        ;;
      "Microsoft Edge")
        icon_result=":microsoft_edge:"
        ;;
      "Affinity Photo")
        icon_result=":affinity_photo:"
        ;;
      "Sketch")
        icon_result=":sketch:"
        ;;
      "Android Studio")
        icon_result=":android_studio:"
        ;;
      "Bitwarden")
        icon_result=":bit_warden:"
        ;;
      "Affinity Publisher")
        icon_result=":affinity_publisher:"
        ;;
      "Zotero")
        icon_result=":zotero:"
        ;;
      "Sublime Text")
        icon_result=":sublime_text:"
        ;;
      "Warp")
        icon_result=":warp:"
        ;;
      "Messages" | "信息" | "Nachrichten")
        icon_result=":messages:"
        ;;
      "Obsidian")
        icon_result=":obsidian:"
        ;;
      "IntelliJ IDEA")
        icon_result=":idea:"
        ;;
      "Atom")
        icon_result=":atom:"
        ;;
      "FaceTime" | "FaceTime 通话")
        icon_result=":face_time:"
        ;;
      "Yuque" | "语雀")
        icon_result=":yuque:"
        ;;
      "Grammarly Editor")
        icon_result=":grammarly:"
        ;;
      "Mattermost")
        icon_result=":mattermost:"
        ;;
      "Affinity Designer")
        icon_result=":affinity_designer:"
        ;;
      "mpv")
        icon_result=":mpv:"
        ;;
      "Thunderbird")
        icon_result=":thunderbird:"
        ;;
      "Airmail")
        icon_result=":airmail:"
        ;;
      "Microsoft Teams")
        icon_result=":microsoft_teams:"
        ;;
      "Bear")
        icon_result=":bear:"
        ;;
      "System Preferences" | "System Settings" | "系统设置")
        icon_result=":gear:"
        ;;
      "Nova")
        icon_result=":nova:"
        ;;
      "WhatsApp")
        icon_result=":whats_app:"
        ;;
      *)
        icon_result=":default:"
        ;;
      esac
    }

    icon_map "$1"

    echo "$icon_result"
  '';

  sketchybar-plugin-sound = pkgs.writeScript "sketchybar-plugin-sound.sh" ''
  source "${sketchybar-icons}"

    VOLUME=$(osascript -e "output volume of (get volume settings)")
    MUTED=$(osascript -e "output muted of (get volume settings)")

    if [[ $MUTED != "false" ]]; then
        ICON="$SOUND_MUT_ICON"
        VOLUME=0
    else
        case ''${VOLUME} in
            100) ICON="$SOUND_FUL_ICON" ;;
            [7-9][0-9]) ICON="$SOUND_HIG_ICON" ;;
            [3-6][0-9]) ICON="$SOUND_MID_ICON" ;;
            [1-2][0-9]|[1-9]) ICON="$SOUND_LOW_ICON" ;;
            *) ICON="$SOUND_MUT_ICON"
        esac
    fi

    sketchybar -m \
        --set $NAME icon=$ICON \
        --set $NAME label="$VOLUME%"
  '';

  sketchybar-plugin-space = pkgs.writeScript "sketchybar-plugin-space.sh" ''
    #!/bin/bash

    WIDTH="dynamic"
    SELECTED="false"

    if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
        WIDTH="0"
        SELECTED="true"
    fi

    sketchybar --animate tanh 10 --set $NAME \
    icon.highlight=$SELECTED \
    background.highlight=$SELECTED \
    label.width=$WIDTH
  '';

  sketchybar-plugin-time = pkgs.writeScript "sketchybar-plugin-time.sh" ''
    #!/bin/bash

    LABEL=$(date '+%d %B %a %H:%M')
    sketchybar --set $NAME label="$LABEL"
  '';

  sketchybar-plugin-wifi = pkgs.writeScript "sketchybar-plugin-wifi.sh" ''
    #!/usr/bin/env sh

    LABEL="$(networksetup -listallhardwareports | awk '/Wi-Fi/{getline; print $2}')"
    LABEL=$(echo "$LABEL" | sed "s/Current Wi-Fi Network: //")
    sketchybar --set wifi label="$LABEL"
  '';

  sketchybar-item-apple = pkgs.writeScript "sketchybar-item-apple.sh" ''
    #!/bin/bash

    APPLE=(
      icon=$APPLE_ICON
      icon.color=$WHITE
      icon.padding_left=4
      label.drawing=off
      background.padding_left=0
      background.padding_right=22
      background.color=$BG_PRI_CLOR
    )

    sketchybar --add item apple left \
              --set apple "''${APPLE[@]}"
  '';

  sketchybar-item-battery = pkgs.writeScript "sketchybar-item-battery.sh" ''
    #!/bin/bash

    BATTERY=(
      update_freq=120
      icon.font="$FONT:Regular:20.0"
      icon.color=$TEAL
      background.color=$BG_SEC_COLR
      script="${sketchybar-plugin-battery}"
    )

    sketchybar --add item battery right \
              --set battery "''${BATTERY[@]}" \
              --subscribe battery system_woke power_source_change
  '';

  sketchybar-item-cpu = pkgs.writeScript "sketchybar-item-cpu.sh" ''
    #!/bin/bash
    CPU=(
      update_freq=2
      icon.font="$FONT:Regular:16.0"
      icon=
      icon.color=$RED
      background.color=$BG_SEC_COLR
      script="${sketchybar-plugin-cpu}"
    )

    sketchybar --add item cpu right \
              --set cpu "''${CPU[@]}" 
  '';

  sketchybar-item-front-app = pkgs.writeScript "sketchybar-item-front-app.sh" ''
    #!/bin/bash

    FRONT_APP=(
      label.font="$FONT:ExtraBold:14.0"
      icon.font="sketchybar-app-font:Regular:16.0" \
      icon.color=$BG_PRI_COLR
      label.color=$BG_PRI_COLR
      background.color=$LAVENDER
      script="${sketchybar-plugin-front-app}"
    )

    sketchybar --add item front_app left \
              --set front_app "''${FRONT_APP[@]}" \
              --subscribe front_app front_app_switched
  '';

  sketchybar-item-sound = pkgs.writeScript "sketchybar-item-sound.sh" ''
    #!/bin/bash

    SOUND=(
      icon.font="$FONT:Regular:20.0"
      icon.color=$GREEN
      background.color=$BG_SEC_COLR
      script="${sketchybar-plugin-sound}"
    )

    sketchybar --add item sound right \
    --set sound "''${SOUND[@]}" \
    --subscribe sound volume_change 
  '';

  sketchybar-item-spaces = pkgs.writeScript "sketchybar-item-spaces.sh" ''
    #!/bin/bash

    # SPACE_ICONS=("~" "1:DEV" "2:WEB" "3:TODO" "4:NOTE" "5:CHAT" "6:WIP")

    SPACE=(
      label.padding_left=6
      label.padding_right=6
      icon.padding_left=0
      icon.padding_right=0
      icon.color=$WHITE
      icon.font="$FONT:ExtraBold:14.0"
      icon.highlight_color=$SKY
      icon.background.draw=on
      background.padding_left=2
      background.padding_right=2
      background.color=$BG_SEC_COLR
      background.corner_radius=10
      background.drawing=off
      # label.drawing=off
    )

    sketchybar --add event aerospace_workspace_change

    for sid in $(aerospace list-workspaces --all); do
        sketchybar --add item space.$sid left \
            --subscribe space.$sid aerospace_workspace_change \
            --set space.$sid "''${SPACE[@]}" \
            script="${sketchybar-aerospace-window-plugin} space.$sid" \
            click_script="aerospace workspace $sid" \
            label="$sid"
            # --set space.$sid icon=''${SPACE_ICONS[i]}
            # script="${sketchybar-plugin-space} $sid" \
    done


    sketchybar --add item space_separator_left left \
              --set space_separator_left icon= \
                                    icon.font="$FONT:Bold:16.0" \
                                    background.padding_left=16 \
                                    background.padding_right=10 \
                                    label.drawing=off \
                                    icon.color=$DARK_WHITE   
  '';

  sketchybar-item-time = pkgs.writeScript "sketchybar-item-time.sh" ''
    #!/bin/bash

    TIME=(
      update_freq=10
      icon.drawing=off
      label.padding_left=10
      label.padding_right=6
      background.padding_right=2
      script="${sketchybar-plugin-time}"
    )

    sketchybar --add item time right \
              --set time "''${TIME[@]}" 
  '';

  sketchybar-item-wifi = pkgs.writeScript "sketchybar-item-wifi.sh" ''
    #!/bin/bash
      WIFI=(
      update_freq=10
      icon.font="$FONT:Regular:20.0"
      icon=$WIFI_CONN_ICON
      icon.color=$PEACH
      background.color=$BG_SEC_COLR
      script="${sketchybar-plugin-wifi}"
    )

    sketchybar --add item wifi right   \
              --set wifi "''${WIFI[@]}" \
              --subscribe wifi wifi_change
  '';
in

{

  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
     agenix.darwinModules.default
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = 6;
        inner.vertical = 6;
        outer.top = [{ monitor.built-in = 4; } 36 ];
        outer.left = 6;
        outer.bottom = 6;
        outer.right = 6;
      };
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        # Setting the FOCUSED_WORKSPACE variable does not work here, thats why the sketchybar script just uses aerospace list-workspaces --focused
        "echo $(env) >> /tmp/aerospace.log; ${pkgs.sketchybar}/bin/sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=\"space.$AEROSPACE_FOCUSED_WORKSPACE\""
      ];
      workspace-to-monitor-force-assignment = {
        "1" = "main";
        "2" = "main";
        "3" = "main";
        "4" = "main";
        "5" = "main";
        "6" = 1;
        "7" = 1;
        "8" = 1;
        "9" = 1;
        "10" = 1;
        "A" = 3;
        "B" = 3;
        "C" = 3;
        "D" = 3;
        "E" = 3;
      };
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
        alt-a = "workspace A";
        alt-b = "workspace B";
        alt-c = "workspace C";
        alt-d = "workspace D";
        alt-e = "workspace E";
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
        alt-shift-a = "move-node-to-workspace A";
        alt-shift-b = "move-node-to-workspace B";
        alt-shift-c = "move-node-to-workspace C";
        alt-shift-d = "move-node-to-workspace D";
        alt-shift-e = "move-node-to-workspace E";
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

        # See: https://nikitabobko.github.io/AeroSpace/commands#mode
        alt-shift-semicolon = "mode service";
      };
    };
  };

  services.jankyborders = {
    enable = true;
    width = 5.0;
    active_color = "#FF81A1C1";
    inactive_color = "#FF2E3440";
    hidpi = true;
    style = "square";
  };

  services.sketchybar = {
    enable = true;

    config = ''
#!/bin/bash

ITEM_DIR="$DIR/items"

FONT="Iosevka Nerd Font"
ICON_FONT="sketchybar-app-font"

PADDING=6

source "${sketchybar-colors}"
source "${sketchybar-icons}"

BAR_PROPS=(
  height=28
  color=$BG_PRI_COLR
  shadow=off
  position=top
  sticky=on
  padding_right=15
  padding_left=15
  corner_radius=10
  y_offset=4
  margin=6
  blur_radius=30
  notch_width=0
)

DEF_PROPS=(
  updates=when_shown
  icon.font="$ICON_FONT:Regular:16.0"
  icon.color=$WHITE
  icon.padding_left=10
  icon.padding_right=2
  label.font="$FONT:Bold:14.0"
  label.color=$WHITE
  label.padding_left=$PADDING
  label.padding_right=10
  background.color=$BG_PRI_COLOR
  background.padding_right=$PADDING
  background.padding_left=$PADDING
  background.height=22
  background.corner_radius=8
)

sketchybar --bar "''${BAR_PROPS[@]}"
sketchybar --default "''${DEF_PROPS[@]}"

# -- LEFT Side Items --
source "${sketchybar-item-apple}"
source "${sketchybar-item-spaces}"
source "${sketchybar-item-front-app}"

# -- RIGHT Side Items -- 
source "${sketchybar-item-time}"
source "${sketchybar-item-battery}"
source "${sketchybar-item-sound}"
source "${sketchybar-item-wifi}"
source "${sketchybar-item-cpu}"
sketchybar --add item cat center \
           --set cat icon="(ﾉ◕ヮ◕)ﾉ*:・✧ﾟ"\
                     icon.font="$ICON_FONT:Regular:18.0" \
                     icon.color=$DARK_WHITE\
                     label.draw=off
           # --set cat icon="≽^•⩊•^≼"\

##### Force all scripts to run the first time (never do this in a script) #####
sketchybar --update
    '';
  };


  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = [ "@admin" "${user}" ];
      substituters = [ "https://nix-community.cachix.org" "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs; [
  #   emacs-unstable
    agenix.packages."${pkgs.system}".default
  ] ++ (import ../../modules/shared/packages.nix { inherit pkgs; });

  astroNvim = {
    username = "linucc";
    nerdfont = "Iosevka";
    nodePackage = pkgs.nodejs_20;
    pythonPackage = pkgs.python311Full;
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
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
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
