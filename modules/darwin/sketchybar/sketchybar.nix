{
  pkgs,
  config,
  ...
}: let
  sketchybarPath = "${config.home.homeDirectory}/code/nix/nix-home/modules/darwin/sketchybar-3/config";
in {
  xdg.configFile."sketchybar".source = config.lib.file.mkOutOfStoreSymlink sketchybarPath;

  programs.sketchybar = {
    enable = true;
    service = {
      enable = true;
      errorLogFile = /tmp/sketchyerr;
      outLogFile = /tmp/sketchylog;
    };
    configType = "lua";
    luaPackage = pkgs.lua5_4;
    sbarLuaPackage = pkgs.sbarlua;
  };
}
