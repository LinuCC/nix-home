print("[sketchybar] Initializing sketchybar module")
local sbar = require("sketchybar")
print("[sketchybar] Configuring sketchybar")

sbar.begin_config()

sbar.add("event", "colors_toggled")
sbar.add("event", "colors_cli_toggle")
sbar.add("event", "media_stream_changed")
sbar.add("event", "media_app_inactive")
require("bar")
require("default")
require("items")

sbar.end_config()

sbar.event_loop()
