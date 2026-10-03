# Nushell Config File

# For more information on defining custom themes, see
# https://www.nushell.sh/book/coloring_and_theming.html
# And here is the theme collection
# https://github.com/nushell/nu_scripts/tree/main/themes
let dark_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    bool: { if $in { 'light_cyan' } else { 'light_gray' } }
    int: white
    filesize: {|e|
      if $e == 0b {
        'white'
      } else if $e < 1mb {
        'cyan'
      } else { 'blue' }
    }
    duration: white
    date: { (date now) - $in |
      if $in < 1hr {
        'red3b'
      } else if $in < 6hr {
        'orange3'
      } else if $in < 1day {
        'yellow3b'
      } else if $in < 3day {
        'chartreuse2b'
      } else if $in < 1wk {
        'green3b'
      } else if $in < 6wk {
        'darkturquoise'
      } else if $in < 52wk {
        'deepskyblue3b'
      } else { 'dark_gray' }
    }    
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cellpath: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray

    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
}

let light_theme = {
    # color for nushell primitives
    separator: dark_gray
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    # Closures can be used to choose colors for specific values.
    # The value (in this case, a bool) is piped into the closure.
    bool: { if $in { 'dark_cyan' } else { 'dark_gray' } }
    int: dark_gray
    filesize: {|e|
      if $e == 0b {
        'dark_gray'
      } else if $e < 1mb {
        'cyan_bold'
      } else { 'blue_bold' }
    }
    duration: dark_gray
  date: { (date now) - $in |
    if $in < 1hr {
      'red3b'
    } else if $in < 6hr {
      'orange3'
    } else if $in < 1day {
      'yellow3b'
    } else if $in < 3day {
      'chartreuse2b'
    } else if $in < 1wk {
      'green3b'
    } else if $in < 6wk {
      'darkturquoise'
    } else if $in < 52wk {
      'deepskyblue3b'
    } else { 'dark_gray' }
  }
    range: dark_gray
    float: dark_gray
    string: dark_gray
    nothing: dark_gray
    binary: dark_gray
    cellpath: dark_gray
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray

    shape_and: purple_bold
    shape_binary: purple_bold
    shape_block: blue_bold
    shape_bool: light_cyan
    shape_custom: green
    shape_datetime: cyan_bold
    shape_directory: cyan
    shape_external: cyan
    shape_externalarg: green_bold
    shape_filepath: cyan
    shape_flag: blue_bold
    shape_float: purple_bold
    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_globpattern: cyan_bold
    shape_int: purple_bold
    shape_internalcall: cyan_bold
    shape_list: cyan_bold
    shape_literal: blue
    shape_matching_brackets: { attr: u }
    shape_nothing: light_cyan
    shape_operator: yellow
    shape_or: purple_bold
    shape_pipe: purple_bold
    shape_range: yellow_bold
    shape_record: cyan_bold
    shape_redirection: purple_bold
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_table: blue_bold
    shape_variable: purple
}

# Terafox theme from nightfox.nvim
# https://github.com/EdenEast/nightfox.nvim
let terafox_theme = {
    # color for nushell primitives
    separator: "#6d7f8b"
    leading_trailing_space_bg: "#254147"
    header: "#cbd9d8"
    empty: "#5a93aa"
    bool: "#ff9664"
    int: "#ff8349"
    filesize: "#ff8349"
    duration: "#7aa4a1"
    date: "#7aa4a1"
    range: "#ebebeb"
    float: "#ff8349"
    string: "#7aa4a1"
    nothing: "#ebebeb"
    binary: "#ff8349"
    cellpath: "#ebebeb"
    row_index: "#587b7b"
    record: "#ebebeb"
    list: "#cbd9d8"
    block: "#cbd9d8"
    hints: "#587b7b"
    search_result: { fg: "#152528" bg: "#7aa4a1" }  # used by `input list --fuzzy`

    # shapes (syntax highlighting)
    shape_and: { fg: "#ad5c7c" attr: b }
    shape_binary: { fg: "#ff8349" attr: b }
    shape_block: "#cbd9d8"
    shape_bool: "#ff9664"
    shape_custom: { fg: "#7aa4a1" attr: b }
    shape_datetime: { fg: "#7aa4a1" attr: b }
    shape_directory: "#ebebeb"
    shape_external: "#ad5c7c"
    shape_externalarg: "#ebebeb"
    shape_filepath: "#ebebeb"
    shape_flag: "#a1cdd8"
    shape_float: "#ff8349"
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b }
    shape_globpattern: "#fdb292"
    shape_int: "#ff8349"
    shape_internalcall: "#ad5c7c"
    shape_list: "#cbd9d8"
    shape_literal: "#7aa4a1"
    shape_matching_brackets: { attr: u }
    shape_nothing: "#afd4de"
    shape_operator: "#cbd9d8"
    shape_or: { fg: "#ad5c7c" attr: b }
    shape_pipe: { fg: "#ad5c7c" attr: b }
    shape_range: { fg: "#ebebeb" attr: b }
    shape_record: "#cbd9d8"
    shape_redirection: { fg: "#ad5c7c" attr: b }
    shape_signature: { fg: "#7aa4a1" attr: b }
    shape_string: "#7aa4a1"
    shape_string_interpolation: "#fdb292"
    shape_table: "#cbd9d8"
    shape_variable: "#ebebeb"
}


# $env.PATH = (
#     $env.PATH | append [
#       $"($env.HOME)/.asdf/installs/rust/stable/bin"
#       $"($env.HOME)/.asdf/bin"
#       $"($env.HOME)/.asdf/shims"
#       $"($env.HOME)/.pub-cache/bin"
#       "/opt/homebrew/opt/asdf/libexec/bin"
#       $"($env.HOME)/.local/bin"
#       "/opt/homebrew/bin"
#       "/opt/homebrew/sbin"
#       "/opt/homebrew/opt/fzf/bin"
#       $"($env.HOME)/.cargo/bin"
#       $"($env.HOME)/bin"
#       "/usr/local/bin"
#     ] | flatten
# )

$env.EDITOR = 'nvim'
$env.HOMEBREW_CELLAR = '/opt/homebrew/Cellar'
$env.HOMEBREW_PREFIX = '/opt/homebrew'
$env.HOMEBREW_REPOSITORY = '/opt/homebrew'
$env.INFOPATH = '/opt/homebrew/share/info:/opt/homebrew/share/info:'
$env.LANG = 'en-US.UTF-8'
$env.LC_ALL = 'en_US.UTF-8'
$env.LC_CTYPE = 'en_US.UTF-8'
$env.NORD_AURORA1 = '#BF616A'
$env.NORD_AURORA2 = '#D08770'
$env.NORD_AURORA3 = '#EBCB8B'
$env.NORD_AURORA4 = '#A3BE8C'
$env.NORD_AURORA5 = '#B48EAD'
$env.NORD_BLUE1 = '#8FA1B3'
$env.NORD_BLUE2 = '#88c0d0'
$env.NORD_BLUE3 = '#81a1c1'
$env.NORD_BLUE4 = '#5e81ac'
$env.NORD_DARK1 = '#2E3440'
$env.NORD_DARK2 = '#3B4252'
$env.NORD_DARK3 = '#434C5E'
$env.NORD_DARK4 = '#4C566A'
$env.NORD_WHITE1 = '#D8DEE9'
$env.NORD_WHITE2 = '#E5E9F0'
$env.NORD_WHITE3 = '#ECEFF4'
$env.TERM = 'xterm-256color'

alias gss = git status
alias gd = git diff
alias gdc = git diff --cached
alias gco = git checkout
alias gc = git commit
alias gca = git commit --amend
alias gst = git stash
alias gstp = git stash pop
alias gsta = git stash apply
alias gp = git push
alias gl = git pull
alias gcp = git cherry-pick
alias gaa = git add --all
alias grh = git reset HEAD
alias gr = git reset

let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

# The default config record. This is where much of your global configuration is setup.
$env.config = {
  ls: {
    use_ls_colors: true # use the LS_COLORS environment variable to colorize output
    clickable_links: true # enable or disable clickable links. Your terminal has to support links.
  }
  rm: {
    always_trash: false # always act as if -t was given. Can be overridden with -p
  }
  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }

  explore: {
    help_banner: true
    exit_esc: true

    command_bar_text: '#C4C9C6'
    # command_bar: {fg: '#C4C9C6' bg: '#223311' }

    status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6' }
    # status_bar_text: {fg: '#C4C9C6' bg: '#223311' }

    highlight: {bg: 'yellow' fg: 'black' }
    status: {
      # warn: {bg: 'yellow', fg: 'blue'}
      # error: {bg: 'yellow', fg: 'blue'}
      # info: {bg: 'yellow', fg: 'blue'}
    }

    try: {
      # border_color: 'red'
      # highlighted_color: 'blue'

      # reactive: false
    }

    table: {
      split_line: '#404040'

      cursor: true

      line_index: true
      line_shift: true
      line_head_top: true
      line_head_bottom: true

      show_head: true
      show_index: true

      # selected_cell: {fg: 'white', bg: '#777777'}
      # selected_row: {fg: 'yellow', bg: '#C1C2A3'}
      # selected_column: blue

      # padding_column_right: 2
      # padding_column_left: 2

      # padding_index_left: 2
      # padding_index_right: 1
    }

    config: {
      cursor_color: {bg: 'yellow' fg: 'black' }

      # border_color: white
      # list_color: green
    }
  }

  history: {
    max_size: 10000 # Session has to be reloaded for this to take effect
    sync_on_enter: false # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
  }
  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "fuzzy"  # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: $carapace_completer # check 'carapace_completer' 
    }
  }
  filesize: {
    unit: "metric"
  }
  cursor_shape: {
    emacs: line # block, underscore, line (line is the default)
    vi_insert: block # block, underscore, line (block is the default)
    vi_normal: underscore # block, underscore, line  (underscore is the default)
  }
  color_config: $terafox_theme   # options: $dark_theme, $light_theme, $terafox_theme
  footer_mode: 25 # always, never, number_of_rows, auto
  float_precision: 2 # the precision for displaying floats in tables
  # buffer_editor: "emacs" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  edit_mode: vi # emacs, vi
  shell_integration: {
  # osc2 abbreviates the path if in the home_dir, sets the tab/window title, shows the running command in the tab/window title
  osc2: true
  # osc7 is a way to communicate the path to the terminal, this is helpful for spawning new tabs in the same directory
  osc7: true
  # osc8 is also implemented as the deprecated setting ls.show_clickable_links, it shows clickable links in ls output if your terminal supports it
  osc8: true
  # osc9_9 is from ConEmu and is starting to get wider support. It's similar to osc7 in that it communicates the path to the terminal
  osc9_9: false
  # osc133 is several escapes invented by Final Term which include the supported ones below.
  # 133;A - Mark prompt start
  # 133;B - Mark prompt end
  # 133;C - Mark pre-execution
  # 133;D;exit - Mark execution finished with exit code
  # This is used to enable terminals to know where the prompt is, the command is, where the command finishes, and where the output of the command is
  osc133: true
  # osc633 is closely related to osc133 but only exists in visual studio code (vscode) and supports their shell integration features
  # 633;A - Mark prompt start
  # 633;B - Mark prompt end
  # 633;C - Mark pre-execution
  # 633;D;exit - Mark execution finished with exit code
  # 633;E - NOT IMPLEMENTED - Explicitly set the command line with an optional nonce
  # 633;P;Cwd=<path> - Mark the current working directory and communicate it to the terminal
  # and also helps with the run recent menu in vscode
  osc633: true
  # reset_application_mode is escape \x1b[?1l and was added to help ssh work better
  reset_application_mode: true
} # enables terminal markers and a workaround to arrow keys stop working issue
  # true or false to enable or disable the welcome banner at startup
  show_banner: false
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

  hooks: {
    pre_prompt: [{
      null  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{
      null  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        null  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
    display_output: {
      if (term size).columns >= 100 { table -e } else { table }
    }
  }
  menus: [
      # Configuration for default nushell menus
      # Note the lack of source parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            scope commands
            | where name =~ $buffer
            | each { |it| {value: $it.name description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            scope variables
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            scope commands
            | where name =~ $buffer
            | each { |it| {value: $it.name description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [emacs vi_normal vi_insert]
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

# source ~/.config/nu/completions/git-completions.nu
# source ~/.config/nu/completions/yarn-completions.nu

source ~/.cache/starship/init.nu
# source "/Users/linucc/Library/Application Support/nushell/rtx.nu"

# GPG Yubikey stuff
$env.GPG_TTY = $"(tty)"
$env.SSH_AUTH_SOCK = $"(gpgconf --list-dirs agent-ssh-socket)"
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null

def --env enable-ping [threshold_ms: int = 10_000] {
    # 1. Define the logic as a closure
    let ping_code = {
        let duration = ($env.CMD_DURATION_MS? | default 0 | into int)
        if $duration > $threshold_ms {
            job spawn {
              afplay /System/Library/Sounds/Morse.aiff
            }
            print $"(ansi g)Done! (ansi reset)Took ($duration)ms"
        }
    }

    # 2. Deep merge the hook into the existing config
    $env.config = ($env.config | merge {
        hooks: {
            # Note: 0.110.0 often uses 'display_output' or 'pre_prompt' 
            # as the reliable hook points. We'll use 'pre_prompt' here 
            # because it triggers right after a command finishes.
            pre_prompt: [ $ping_code ]
        }
    })

    print $"Ping enabled for commands > ($threshold_ms)ms"
}






# devenv hook for nushell
#
# Loaded automatically (no config.nu edit needed) when devenv is installed via
# Nix, which ships this under $nu.vendor-autoload-dirs. If you're running a
# devenv build that didn't install it there, add it to your own autoload dir:
#   mkdir ($nu.default-config-dir | path join autoload)
#   devenv hook nu | save --force ($nu.default-config-dir | path join autoload/devenv-hook.nu)

# The project dir we last auto-activated. Lets you `exit` a devenv shell back to
# the parent shell without it immediately re-spawning; cleared once you cd
# elsewhere. `devenv hook-should-activate` is cheap (static binary), so apart
# from this guard the hook runs it every prompt — no result caching, so
# `devenv allow`/`revoke` take effect on the next prompt without a re-`cd`.
$env._DEVENV_HOOK_ACTIVATED = ""
# Last directory reported as untrusted, so the "not allowed" hint is shown once
# per entry rather than on every prompt.
$env._DEVENV_HOOK_UNTRUSTED = ""

# `_DEVENV_HOOK_DIR` marks the one shell process the hook itself spawned;
# it gates the cd-out `exit` so externally-set `DEVENV_ROOT` (e.g. via
# direnv) does not close the user's terminal. Capture it into a plain
# variable, then remove it from `$env` so it cannot leak into further
# descendants (a new tmux/zellij pane, a manually started nested
# shell, ...) started from this shell later on — those would otherwise
# inherit it, wrongly conclude they too are hook-spawned, and `exit` on
# cd-out with nothing around to catch them.
let _devenv_hook_dir = ("_DEVENV_HOOK_DIR" in $env)
hide-env -i _DEVENV_HOOK_DIR

def --env _devenv_hook [] {
    if ("DEVENV_ROOT" in $env) {
        if $_devenv_hook_dir {
            if not ($env.PWD == $env.DEVENV_ROOT or ($env.PWD | str starts-with ($env.DEVENV_ROOT + "/"))) {
                $env.PWD | save --force ($env.DEVENV_ROOT + "/.devenv/exit-dir")
                # `exit` throws ShellError::Exit, which is only handled at the
                # REPL top level; from inside a hook nushell reports
                # "Exit doesn't catch internally" and the shell survives.
                # Signal ourselves instead so the process really terminates.
                ^kill $nu.pid
            }
        }
        return
    }

    # Just exited the devenv shell for this dir — don't re-spawn until you leave.
    if ($env._DEVENV_HOOK_ACTIVATED == $env.PWD) {
        return
    }
    $env._DEVENV_HOOK_ACTIVATED = ""

    let result = (^devenv hook-should-activate | complete)
    let retrying = ($env._DEVENV_HOOK_UNTRUSTED == $env.PWD)
    if not $retrying and ($result.stderr | str trim) != "" {
        print -e $result.stderr
    }

    if $result.exit_code == 0 {
        let dir = ($result.stdout | str trim)
        if $dir != "" {
            $env._DEVENV_HOOK_UNTRUSTED = ""
            # Mark activated before launching so exiting the shell doesn't re-launch.
            $env._DEVENV_HOOK_ACTIVATED = $env.PWD
            # `try`: a hook-spawned shell that leaves the project terminates
            # itself with a signal, so `devenv shell` exits 128+SIGTERM. Without
            # `try` nushell aborts the hook on that non-zero exit and never
            # follows the user to `exit-dir` below.
            try {
                with-env { _DEVENV_HOOK_DIR: $dir, _DEVENV_CALLER: "hook", _DEVENV_SHELL_HINT: "nu" } { do { ^devenv shell } }
            }
            let exit_dir_file = ($dir + "/.devenv/exit-dir")
            if ($exit_dir_file | path exists) {
                let target_dir = (open $exit_dir_file | str trim)
                rm -f $exit_dir_file
                if ($target_dir | path exists) {
                    cd $target_dir
                    # We followed the user out, so the "don't re-spawn" guard
                    # above no longer applies: it only exists for exiting the
                    # shell and staying put. Leaving it set to the project dir
                    # would silently skip activation the next time the user
                    # cd's back in.
                    $env._DEVENV_HOOK_ACTIVATED = ""
                }
            }
        } else {
            $env._DEVENV_HOOK_UNTRUSTED = ""
        }
    } else {
        $env._DEVENV_HOOK_UNTRUSTED = $env.PWD
    }
}

# Run on every prompt. hook-should-activate is cheap, so there's no separate
# env_change/PWD trigger or trust-DB stamp: each prompt re-checks, which makes
# `devenv allow`/`revoke` (and out-of-tree bindings) take effect immediately.
$env.config = ($env.config | upsert hooks.pre_prompt (
    ($env.config | get -o hooks.pre_prompt | default []) | append {|| _devenv_hook }
))
