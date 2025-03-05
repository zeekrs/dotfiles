local settings = require("settings")
local get_app_label = require("utils.get_app_label")
local colors = require("colors")
local email = Bar.add("item", {
	position = "right",
	icon = {
		string = "󰇮",
		color = colors.blue,
		font = {
			family = settings.font.nerd,
		},
	},
	label = {
		font = {
			family = settings.font.numbers,
		},
	},
	update_freq = 6,
})

local function update()
	get_app_label("Spark", function(label)
		email:set({
			label = {
				string = label,
			},
		})
	end)
end

email:subscribe({ "routine", "system_woke" }, function()
	update()
end)

email:subscribe("mouse.clicked", function()
	Bar.exec([[
		open -a Spark
	]])
end)

update()
