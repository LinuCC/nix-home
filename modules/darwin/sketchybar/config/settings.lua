-- Overrides merged over the defaults in init.lua
return {
  window_manager = 'aerospace',

  fonts = {
    icon = 'Iosevka Nerd Font',
    label = 'Iosevka Nerd Font',
  },

  music = {
    bar_title_max_length = 34,
  },

  modules = {
    -- Polls `brew outdated` and offers `brew upgrade`; brew is managed declaratively by nix-homebrew
    brew = { enabled = false },
  },
}
