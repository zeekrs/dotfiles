local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local apple = Bar.add("item", "apple", {
	icon = {
		color = colors.blue,
		string = icons.apple,
		padding_left = 0,
	},
	background = {
		drawing = false,
		padding_right = settings.item_padding,
	},
	label = {
		drawing = false,
	},
})

apple:subscribe("mouse.clicked", function()
	Bar.exec("open -a launchpad")
end)

Bar.add("item", "separator", {
	width = 16,
	background = {
		image = {
			string = "~/.config/sketchybar/assets/separator.png",
			scale = "0.09",
		},
		padding_left = 0,
		padding_right = 0,
		color = colors.transparent,
	},
})
