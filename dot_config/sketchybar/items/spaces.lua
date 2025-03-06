local settings = require("settings")
local colors = require("colors")

local space_on = settings.default_toggle == "on"

local swap_observer = Bar.add("item", {
	drawing = false,
	updates = true,
})

local icons = {
	"", -- terminal
	"", -- browser
	"", -- work
	"", -- debug
	"󰆼", -- database
	"󰇮", -- email
	"󰎆", -- music
	"", --play
	"", -- others
}

local start_place = Bar.add("item", {
	width = settings.bar_gap,
	background = {
		drawing = false,
	},
})

for i = 1, 9, 1 do
	local space = Bar.add("space", "space." .. i, {
		space = i,
		icon = {
			font = { family = settings.font.nerd },
			string = icons[i],
			padding_left = settings.item_padding,
			padding_right = settings.item_padding,
			color = colors.subtext0,
			highlight_color = colors.lavender,
		},
		label = {
			drawing = false,
		},
		background = {
			drawing = false,
			padding_right = 1,
			padding_left = 1,
		},
		drawing = space_on,
	})

	space:subscribe("mouse.clicked", function(env)
		Bar.exec("yabai -m space --focus " .. env.SID)
	end)

	space:subscribe("space_change", function(env)
		local selected = env.SELECTED == "true"
		space:set({
			icon = { highlight = selected },
		})
	end)
end

Bar.add("bracket", {
	"/space\\..*/",
}, {
	drawing = space_on,
	background = {
		drawing = true,
	},
})

local end_place = Bar.add("item", {
	width = settings.bar_gap,
	background = {
		drawing = false,
	},
})

swap_observer:subscribe("swap_space_and_state", function(toggle)
	local on = toggle.open == "on"
	print(toggle.open)
	Bar.set("/space\\..*/", { drawing = on })
	start_place:set({ drawing = on })
	end_place:set({ drawing = on })
end)
