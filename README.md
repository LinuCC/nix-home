# My dotnix dev setup

If you want to build your own the easy way, check out this awesome starter config: https://github.com/dustinlyons/nixos-config .

If you just want to go with this config on Mac (tested on a fresh Mac, you will otherwise have some fun with existing Homebrew if you have an existing installation):
- Setup Nix as described here: https://github.com/dustinlyons/nixos-config?tab=readme-ov-file#for-macos-november-2024
- Clone this repo 
- Search and replace the username ("linucc") with your own.
- Do you own secret stuff (Have no clue myself atm)

- `nix run .#build`
- `nix run .#build-switch`

## Todos

- [ ] Somehow template configuration for
  - [ ] NuShell
  - [ ] Neovim
  - Mac-specific (probably infeasable amount of work)
    - [ ] Alfred
    - [ ] iStat Menus
- [ ] Get that secrets stuff going
    - Waiting on https://github.com/nix-community/home-manager/issues/5997 to get fixed for my Yubikey
