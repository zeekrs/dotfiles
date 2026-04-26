local settings = require("settings")

local icons = {
	sf_symbols = {
		clock = "􀐫",
		plus = "􀅼",
		loading = "􀖇",
		apple = "􀣺",
		gear = "􀍟",
		cpu = "􀫥",
		ram = "􀫦",
		disk = "􀥾",
		clipboard = "􀉄",
		vpn = "􀵔",
		layout = {
			stack = "􀐋",
			bsp = "􀧈",
			float = "􀏧",
		},
		switch = {
			on = "􁏮",
			off = "􁏯",
		},
		mic = {
			on = "􀊰",
			off = "􀊲",
		},
		volume = {
			_100 = "􀊩",
			_66 = "􀊧",
			_33 = "􀊥",
			_10 = "􀊡",
			_0 = "􀊣",
		},
		battery = {
			_100 = "􀛨",
			_75 = "􀺸",
			_50 = "􀺶",
			_25 = "􀛩",
			_0 = "􀛪",
			charging = "􀢋",
		},
		wifi = {
			upload = "􀄨",
			download = "􀄩",
			connected = "􀙇",
			disconnected = "􀙈",
			router = "􁓤",
		},
		media = {
			back = "􀊊",
			forward = "􀊌",
			play_pause = "􀊈",
		},
		chevron = {
			right = "􀆊",
		},
	},

	-- Alternative NerdFont icons
	nerdfont = {
		clock = "",
		plus = "",
		loading = "",
		apple = "",
		gear = "",
		cpu = "",
		ram = "󰍛",
		disk = "",
		clipboard = "Missing Icon",
		vpn = "󰒃",

		switch = {
			on = "󱨥",
			off = "󱨦",
		},
		mic = {
			on = "",
			off = "",
		},
		volume = {
			_100 = "",
			_66 = "",
			_33 = "",
			_10 = "",
			_0 = "",
		},
		battery = {
			_100 = "",
			_75 = "",
			_50 = "",
			_25 = "",
			_0 = "",
			charging = "",
		},
		wifi = {
			upload = "",
			download = "",
			connected = "󰖩",
			disconnected = "󰖪",
			router = "Missing Icon",
		},
		media = {
			back = "",
			forward = "",
			play_pause = "",
		},
	},
}

if not (settings.icons == "NerdFont") then
	return icons.sf_symbols
else
	return icons.nerdfont
end
