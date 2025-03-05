local settings = require("settings")
local get_app_label = require("utils.get_app_label")
local wechat = Bar.add("item", {
	position = "right",
	icon = {
		string = "󰘑",
		color = 0xff2fb608,
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

update()
