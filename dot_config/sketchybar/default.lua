local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
Bar.default({
	updates = "when_shown",
	icon = {
		font = {
			family = settings.font.default,
			style = settings.font.style_map["Regular"],
			size = 16,
		},
		color = colors.text,
		padding_left = settings.item_padding,
		padding_right = settings.item_gap,
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Medium"],
			size = 14.0,
		},
		color = colors.subtext1,
		padding_left = settings.item_gap,
		padding_right = settings.item_padding,
	},
	background = {
		padding_left = settings.bar_gap,
		padding_right = settings.bar_gap,
		color = colors.surface0,
		height = 30,
		corner_radius = 15,
	},
	scroll_texts = true,
})
