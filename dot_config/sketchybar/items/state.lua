local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

Bar.exec(
	"killall stats_provider >/dev/null; $HOME/.local/share/sketchybar_lua/stats_provider --cpu usage  --disk usage --memory ram_usage --bar top_bar --interval 2 --network "
		.. settings.ethernet
)

local state_on = settings.default_toggle == "off"

local swap_observer = Bar.add("item", {
	drawing = false,
	updates = true,
})

local cpu = Bar.add("item", "state.cpu", {
	icon = {
		string = icons.cpu,
		color = colors.red,
	},
	label = {
		string = "??%",
		font = {
			family = settings.font.mono,
		},
	},
	drawing = state_on,
})

cpu:subscribe("mouse.clicked", function()
	Bar.exec([[
		open -a "Activity Monitor"
		osascript -e '
			tell application "Activity Monitor"
				activate
			end tell
			delay 0.5
			tell application "System Events"
				tell process "Activity Monitor"
					tell radio group 1 of group 1 of toolbar 1 of window 1
						click radio button 1
					end tell
				end tell
			end tell'
	]])
end)

local ram = Bar.add("item", "state.ram", {
	icon = {
		string = icons.ram,
		color = colors.sapphire,
	},
	label = {
		string = "??%",
		font = {
			family = settings.font.mono,
		},
	},
	drawing = state_on,
})

ram:subscribe("mouse.clicked", function()
	Bar.exec([[
		open -a "Activity Monitor"
		osascript -e '
			tell application "Activity Monitor"
				activate
			end tell
			delay 0.5
			tell application "System Events"
				tell process "Activity Monitor"
					tell radio group 1 of group 1 of toolbar 1 of window 1
						click radio button 2
					end tell	
				end tell
			end tell'
	]])
end)

local disk = Bar.add("item", "state.disk", {
	icon = {
		string = icons.disk,
		color = colors.peach,
	},
	label = {
		string = "??%",
		font = {
			family = settings.font.mono,
		},
	},
	drawing = state_on,
})

disk:subscribe("mouse.clicked", function()
	Bar.exec([[
		open -a "System Settings"
		osascript -e '
			tell application "System Settings"
				activate
			end tell
			delay 0.1
			tell application "System Settings"
				set current pane to pane id "com.apple.settings.Storage"
			end tell'
	]])
end)

local state_observer = Bar.add("item", "state_observer", {
	drawing = false,
	updates = state_on,
})

local function normalize_value(value)
	local leader = ""
	if #value < 3 then
		leader = "0"
	end
	return leader .. value
end

state_observer:subscribe("system_stats", function(env)
	cpu:set({
		label = { string = normalize_value(env["CPU_USAGE"]) },
	})
	ram:set({
		label = { string = normalize_value(env["RAM_USAGE"]) },
	})
	disk:set({
		label = { string = normalize_value(env["DISK_USAGE"]) },
	})
end)

swap_observer:subscribe("swap_space_and_state", function(toggle)
	local on = toggle.open == "off"
	Bar.set("/state\\..*/", { drawing = on })
	state_observer:set({
		updates = on,
	})
end)
