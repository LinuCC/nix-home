{ config, pkgs, lib, ... }:

let name = "LinuCC";
    user = "linucc";
    email = "linucc@linu.cc"; 
in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    plugins = [
    ];
    initExtraFirst = ''
      # gpg-agent for me yubikey
      unset SSH_AGENT_PID
      if [ "''${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
        export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
      fi
      export GPG_TTY=$(tty)
      gpg-agent updatestartuptty /bye >/dev/null

      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Ripgrep alias
      alias search=rg -p --glob '!node_modules/*'  $@

      export EDITOR="nvim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # pnpm is a javascript package manager
      # alias pn=pnpm
      # alias px=pnpx

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
      push.autoSetupRemote = true;
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Nord";
        true-color = "always";
      };
    };
  };

  mise = {
    enable = true;
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify vim-tmux-navigator ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/.local/share/src',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
     };

  alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };

      window = {
        dynamic_title = true;
        opacity = 0.9;

        dimensions = {
          columns = 80;
          lines = 24;
        };

        padding = {
          x = 0;
          y = 0;
        };

        decorations = "none";
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        normal = {
          # family = "Iosevka Nerd Font";
          family = "M+1Code Nerd Font";
          style = "Regular";
        };
        bold = {
          # family = "Iosevka Nerd Font";
          family = "M+1Code Nerd Font";
          style = "Medium";
        };
        italic = {
          # family = "Iosevka Nerd Font";
          family = "M+1Code Nerd Font";
          style = "Italic";
        };
        size = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 12)
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 13)
        ];
      };

      bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;
      };

      terminal = {
        shell = {
          program = "/bin/zsh";
          args = [ "--login"];
        };
      };
      
      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5abb6";
        };
        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
        };
        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };
        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
        transparent_background_colors = true;
      };
    };
  };

  nushell = {
    enable = true;
    configFile.source = ./config/nu/config.nu;
    extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell $spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )
      '' + ''
        export-env {
          $env.MISE_SHELL = "nu"
          
          $env.config = ($env.config | upsert hooks {
              pre_prompt: ($env.config.hooks.pre_prompt ++
              [{
              condition: {|| "MISE_SHELL" in $env }
              code: {|| mise_hook }
              }])
              env_change: {
                  PWD: ($env.config.hooks.env_change.PWD ++
                  [{
                  condition: {|| "MISE_SHELL" in $env }
                  code: {|| mise_hook }
                  }])
              }
          })
        }
          
        def "parse vars" [] {
          $in | lines | parse "{op},{name},{value}"
        }
          
        def --env mise [command?: string, --help, ...rest: string] {
          let commands = ["shell", "deactivate"]
          
          if ($command == null) {
            ^"${pkgs.mise}/bin/mise"
          } else if ($command == "activate") {
            $env.MISE_SHELL = "nu"
          } else if ($command in $commands) {
            ^"${pkgs.mise}/bin/mise" $command $rest
            | parse vars
            | update-env
          } else {
            ^"${pkgs.mise}/bin/mise" $command ...$rest
          }
        }
          
        def --env "update-env" [] {
          for $var in $in {
            if $var.op == "set" {
              load-env {($var.name): $var.value}
            } else if $var.op == "hide" {
              hide-env $var.name
            }
          }
        }
          
        def --env mise_hook [] {
          ^"${pkgs.mise}/bin/mise" hook-env -s nu
            | parse vars
            | update-env
        }
      '' + ''
        # Direnv setup

        { ||
            if (which direnv | is-empty) {
                return
            }

            direnv export json | from json | default {} | load-env
        }
      '';
    envFile.source = ./config/nu/env.nu;
  };

  carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  starship = { 
    enable = true;

    settings = {
      add_newline = true;

   format = ''$shell[](#5E81AC)$os$username[](bg:#81A1C1 fg:#5E81AC)$directory[](fg:#81A1C1 bg:#88C0D0)$git_branch$git_status[](fg:#88C0D0 bg:#8FBCBB)$c$elixir$elm$golang$gradle$haskell$java$julia$nodejs$nim$rust$scala[](fg:#8FBCBB bg:#A3BE8C)$docker_context[](fg:#A3BE8C) '';

    right_format = ''[](fg:#EBCB8B)$time[](fg:#EBCB8B)'';
 
   username = {
     show_always = true;
     style_user = "bg:#5E81AC";
     style_root = "bg:#5E81AC";
     format = "[$user ]($style)";
     disabled = false;
   };
 
   os = {
     style = "bg:#5E81AC fg:#2E3440";
     # disabled = true; # Disabled by default
   };
 
   directory = {
     style = "bg:#81A1C1 fg:#2E3440";
     format = "[ $path ]($style)";
     truncation_length = 3;
     truncation_symbol = "…/";
     substitutions = {
       "Documents" = "󰈙 ";
       "Downloads" = " ";
       "Music" = " ";
       "Pictures" = " ";
     };
   };
 
   c = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   docker_context = {
     symbol = " ";
     style = "bg:#A3BE8C fg:#2E3440";
     format = "[ $symbol $context ]($style)";
   };
 
   elixir = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   elm = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   git_branch = {
     symbol = "";
     style = "bg:#88C0D0 fg:#2E3440";
     format = "[ $symbol $branch ]($style)";
   };
 
   git_status = {
     style = "bg:#88C0D0 fg:#2E3440";
     format = "[$all_status$ahead_behind ]($style)";
   };
 
   golang = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   gradle = {
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   haskell = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   java = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   julia = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   nodejs = {
     symbol = "";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   nim = {
     symbol = "󰆥 ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
      
   nix_shell = {
     symbol = "󱄅 ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol  $name ($state) ]($style)";
   };
 
   rust = {
     symbol = "";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };
 
   scala = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol ($version) ]($style)";
   };

   shell = {
      disabled = false;
      # style = "bg:#B48EAD fg:#2E3440";
      bash_indicator = "[   bsh ](fg:#ebcb8b)";
      zsh_indicator = "[   zsh ](fg:#a3be8c)";
      nu_indicator = "[   nu ](fg:#b48ead)";
      format = "$indicator";
   };

   terraform = {
     symbol = " ";
     style = "bg:#8FBCBB fg:#2E3440";
     format = "[ $symbol $workspace ($version) ]($style)";
   };
 
   time = {
     disabled = false;
     time_format = "%R"; # Hour:Minute Format
     style = "bg:#EBCB8B fg:#2E3440";
     format = "[ 󱑏 $time ]($style)";
   };
     };
   };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
	    # Hopefully this doesnt fuck up the secrets handling...
            # "/home/${user}/.ssh/id_github"
            "/home/${user}/.ssh/id_rsa_yubikey.pub"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            # "/Users/${user}/.ssh/id_github"
            "/Users/${user}/.ssh/id_rsa_yubikey.pub"
          )
        ];
      };
    };
  };

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      fingers
      # https://github.com/nix-community/home-manager/issues/5952
      # sensible
      yank
      prefix-highlight
      nord
      # {
      #   plugin = resurrect; # Used by tmux-continuum
      #
      #   # Use XDG data directory
      #   # https://github.com/tmux-plugins/tmux-resurrect/issues/348
      #   extraConfig = ''
      #     set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
      #     set -g @resurrect-capture-pane-contents 'on'
      #     set -g @resurrect-pane-contents-area 'visible'
      #   '';
      # }
      # {
      #   plugin = continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-save-interval '5' # minutes
      #   '';
      # }
    ];
    terminal = "tmux-256color";
    tmuxinator.enable = true;
    prefix = "C-b";
    escapeTime = 10;
    clock24 = true;
    historyLimit = 50000;
    shell = "${pkgs.nushell}/bin/nu";
    sensibleOnTop = false;
    baseIndex = 1;
    extraConfig = ''

      # Remove Vim mode delays
      set -g focus-events on

      # Enable full mouse support
      set -g mouse on

      # -----------------------------------------------------------------------------
      # Key bindings
      # -----------------------------------------------------------------------------

      # C-a for nested tmux sessions
      bind-key -n C-a send-prefix

      # Split panes, vertical or horizontal
      bind-key x split-window -v
      bind-key v split-window -h

      # Move around panes with vim-like bindings (h,j,k,l)
      bind-key -n M-k select-pane -U
      bind-key -n M-h select-pane -L
      bind-key -n M-j select-pane -D
      bind-key -n M-l select-pane -R

      # Move around panes with vim-like bindings (h,j,k,l) with prefix - useful for nested tmux sessions
      bind-key k select-pane -U
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key l select-pane -R

      # Smart pane switching with awareness of Vim splits.
      # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
      # is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
      #   | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      # bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      # bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      # bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      # bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      # tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      # if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
      #   "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      # if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
      #   "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l

      set-option -g pane-border-lines "heavy"
      set-option -g pane-active-border-style "fg=#ff8349"

      # Some BS around https://github.com/nix-community/home-manager/issues/5952
      set -gu default-command
      set -g default-shell "${pkgs.nushell}/bin/nu"

      # Colored Nvim inside Tmux
      set -ag terminal-overrides ",xterm-256color:RGB"
      '';
    };
}
