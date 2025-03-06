local settings = require("settings")
local colors = require("colors")

local github = Bar.add("item", {
	position = "right",
	icon = {
		string = "",
		color = colors.mauve,
		font = {
			family = settings.font.nerd,
		},
	},
	label = {
		font = {
			family = settings.font.numbers,
		},
	},
	update_freq = 180,
})

local function update()
	Bar.exec([[gh api notifications]], function(notifications)
		github:set({
			label = {
				string = #notifications,
			},
		})
	end)
end

github:subscribe({ "routine", "system_woke" }, function()
	update()
end)

github:subscribe({ "mouse.clicked" }, function()
	Bar.exec("open https://github.com/notifications")
end)
