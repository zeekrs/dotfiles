local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

Bar.add("item", {
	position = "right",
	width = settings.bar_gap,
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
	},
})

local wifi_up_icon = Bar.add("item", "wifi.up.icon", {
	position = "right",
	width = 0,
	y_offset = 6,
	icon = {
		padding_right = settings.item_padding,
		padding_left = 0,
		string = icons.wifi.upload,
		font = {
			size = 9,
		},
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
		padding_right = 0,
	},
})

local wifi_down_icon = Bar.add("item", "wifi.down.icon", {
	position = "right",
	y_offset = -6,
	icon = {
		padding_right = settings.item_padding,
		padding_left = 0,
		string = icons.wifi.download,
		font = {
			size = 9,
		},
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
		padding_right = 0,
	},
})

local wifi_up_num = Bar.add("item", "wifi.up.num", {
	position = "right",
	width = 0,
	y_offset = 6,
	icon = {
		drawing = false,
	},
	label = {
		string = "0KB/s",
		font = {
			size = 9,
		},
		color = colors.yellow,
		padding_right = 0,
	},
	background = {
		padding_right = 0,
		drawing = false,
	},
})

local wifi_down_num = Bar.add("item", "wifi.down.num", {
	position = "right",
	width = 50,
	y_offset = -6,
	icon = {
		drawing = false,
	},
	label = {
		string = "0KB/s",
		font = {
			size = 9,
		},
		color = colors.green,
		padding_right = 0,
	},
	background = {
		padding_right = 0,
		drawing = false,
	},
})

local wifi = Bar.add("item", "wifi.icon", {
	position = "right",
	icon = {
		string = icons.wifi.disconnected,
		padding_left = 16,
		padding_right = 0,
		color = colors.green,
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
		padding_left = 0,
		padding_right = 0,
	},
})

Bar.add("bracket", {
	wifi.name,
	wifi_down_icon.name,
	wifi_up_icon.name,
	wifi_up_num.name,
	wifi_down_num.name,
}, {
	background = {
		drawing = true,
	},
})

Bar.add("item", {
	position = "right",
	width = settings.bar_gap,
	icon = {
		drawing = false,
	},
	label = {
		drawing = false,
	},
	background = {
		drawing = false,
	},
})

wifi:subscribe("mouse.clicked", function()
	Bar.exec([[open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi']])
end)

wifi:subscribe("wifi_change", function()
	Bar.exec("networksetup -getairportpower " .. settings.ethernet, function(output)
		if string.find(output, "On") then
			wifi:set({
				icon = {
					string = icons.wifi.connected,
					color = colors.green,
				},
			})
			wifi_up_icon:set({
				icon = {
					color = colors.yellow,
				},
			})
			wifi_up_num:set({
				label = {
					color = colors.yellow,
				},
			})
			wifi_down_icon:set({
				icon = {
					color = colors.green,
				},
			})
			wifi_down_num:set({
				label = {
					color = colors.green,
				},
			})
		else
			wifi:set({
				icon = {
					string = icons.wifi.disconnected,
					color = colors.red,
				},
			})
			wifi_up_icon:set({
				icon = {
					color = colors.overlay0,
				},
			})
			wifi_up_num:set({
				label = {
					color = colors.overlay0,
				},
			})
			wifi_down_icon:set({
				icon = {
					color = colors.overlay0,
				},
			})
			wifi_down_num:set({
				label = {
					color = colors.overlay0,
				},
			})
		end
	end)
end)

wifi:subscribe("system_stats", function(env)
	local up = env["NETWORK_TX_" .. settings.ethernet]
	local down = env["NETWORK_RX_" .. settings.ethernet]
	wifi_up_num:set({
		label = {
			string = up,
		},
	})
	wifi_down_num:set({
		label = {
			string = down,
		},
	})
end)
