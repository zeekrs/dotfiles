local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local time = Bar.add("item", "time", {
	position = "right",
	icon = {
		string = icons.clock,
		color = colors.sky,
	},
	label = {
		font = {
			family = settings.font.numbers,
		},
	},
	update_freq = 1,
})

time:subscribe({ "routine", "system_woke" }, function()
	Bar.exec("date '+%a. %d %b. %H:%M'", function(datetime)
		time:set({
			label = {
				string = datetime,
			},
		})
	end)
end)

time:subscribe("mouse.clicked", function()
	Bar.exec([[
		open -a "Calendar"
	]])
end)
