--
local colors = require("colors")
local settings = require("settings")
local icons = require("icons")

local indicator = Bar.add("item", {
	icon = {
		color = colors.overlay1,
		string = settings.default_toggle == "on" and icons.switch.on or icons.switch.off,
		padding_right = settings.item_padding,
	},
	label = {
		width = 0,
		string = settings.default_toggle == "on" and "[space]" or "[state]",
		color = colors.text,
		font = {
			family = settings.font.mono,
		},
	},
	background = {
		color = colors.with_alpha(colors.surface0, 0.0),
		border_color = colors.with_alpha(colors.surface0, 0.0),
		padding_right = 0,
	},
})

indicator:subscribe("mouse.exited", function()
	Bar.animate("tanh", 30, function()
		indicator:set({
			background = {
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
			},
			icon = { color = colors.overlay1, padding_right = settings.item_padding },
			label = { width = 0 },
		})
	end)
end)

indicator:subscribe("mouse.entered", function()
	Bar.animate("tanh", 30, function()
		indicator:set({
			background = {
				color = { alpha = 1.0 },
				border_color = { alpha = 1.0 },
			},
			icon = { color = colors.text, padding_right = settings.item_gap },
			label = { width = "dynamic" },
		})
	end)
end)

indicator:subscribe("mouse.clicked", function()
	local currently_on = indicator:query().icon.value == icons.switch.on
	Bar.trigger("swap_space_and_state", { open = currently_on and "off" or "on" })
end)

indicator:subscribe("swap_space_and_state", function(toggle)
	local on = toggle.open == "on"
	indicator:set({
		icon = { string = on and icons.switch.on or icons.switch.off },
		label = { string = on and "[space]" or "[state]" },
	})
end)
