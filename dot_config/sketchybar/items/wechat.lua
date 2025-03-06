local settings = require("settings")
local colors = require("colors")
local get_app_label = require("utils.get_app_label")
local wechat = Bar.add("item", {
	position = "right",
	icon = {
		string = "󰘑",
		color = colors.green,
		font = {
			family = settings.font.nerd,
		},
	},
	label = {
		font = {
			family = settings.font.numbers,
		},
	},
	update_freq = 3,
})

local function update()
	get_app_label("微信", function(label)
		wechat:set({
			label = {
				string = label,
			},
		})
	end)
end

wechat:subscribe({ "routine", "system_woke" }, function()
	update()
end)

wechat:subscribe("mouse.clicked", function()
	Bar.exec([[
		open -a Wechat
	]])
end)
