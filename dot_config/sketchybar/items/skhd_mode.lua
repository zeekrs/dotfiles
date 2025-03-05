local colors = require("colors")
local settings = require("settings")
local skhd_mode = Bar.add("item", {
	position = "right",
	icon = {
		string = "[N]",
		font = {
			family = settings.font.mono,
		},
		color = colors.blue,
		padding_right = settings.item_gap,
		padding_left = settings.item_gap,
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
	},
})

skhd_mode:subscribe("skhd_mode_change", function(env)
	print(env.MODE)

	if env.MODE == "service" then
		skhd_mode:set({
			icon = {
				string = "[S]",
				color = colors.peach,
			},
		})
	else
		skhd_mode:set({
			icon = {
				string = "[N]",
				color = colors.blue,
			},
		})
	end
end)
