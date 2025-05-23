# My dotnix dev setup

If you want to build your own the easy way, check out this awesome starter config: https://github.com/dustinlyons/nixos-config .

If you just want to go with this config on Mac:

- Setup Nix as described here: https://github.com/dustinlyons/nixos-config?tab=readme-ov-file#for-macos-november-2024
- Clone this repo
- Search and replace the username ("linucc") with your own.
- Do you own secret stuff (Have no clue myself atm)

_Note for existing installations_: `nix-homebrew` is set to `zap` all existing packages
if not specified in the config; Remove the line in `modules/darwin/home-manager.nix` if you dont
want to lose your existing packages.

- `nix run .#build`
- `nix run .#build-switch`

## Todos

- [x] Template configuration for
  - [x] NuShell
  - [x] Neovim
  - [x] Tmux
- [ ] Auto-start aerospace
- [ ] Ensure Sketchybar started with Aerospace
- [ ] Cleanup config in
  - `shared/home-manager.nix`
  - `hosts/darwin/default.nix`
  - Mac-specific (probably infeasable amount of work)
    - [ ] Alfred
    - [ ] iStat Menus
- [ ] Get that secrets stuff going
  - Waiting on https://github.com/nix-community/home-manager/issues/5997 to get fixed for my Yubikey

## Example Setup for project-specific local dev environments

- Create a new flake with the necessary dependencies by using a template from https://github.com/the-nix-way/dev-templates?tab=readme-ov-file
- Make direnv use that by executing the following in your project repo: `echo "use flake ~/my/new/flake/path" >> .envrc && direnv allow`
  - More about setting up direnv with nix here: https://github.com/nix-community/nix-direnv?tab=readme-ov-file
