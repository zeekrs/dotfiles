local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

Bar.add("item", {
	width = settings.bar_gap,
	background = {
		drawing = false,
	},
})

local mic_icon = Bar.add("item", "mic.icon", {
	width = 40,
	icon = {
		string = icons.mic.off,
		color = colors.mauve,
	},
	label = {
		drawing = false,
	},
	background = {
		padding_left = 0,
		padding_right = 0,
		drawing = false,
	},
})

local mic_slider = Bar.add("slider", "mic.slider", 100, {
	update_freq = 3,
	updates = true,
	label = { drawing = false },
	icon = { drawing = false },
	background = { drawing = false, padding_left = settings.item_gap, padding_right = settings.item_gap },
	slider = {
		highlight_color = colors.mauve,
		width = 0,
		background = {
			height = 9,
			corner_radius = 3,
			color = colors.base,
		},
		knob = {
			drawing = false,
		},
	},
})

local mic_label = Bar.add("item", "mic.label", {
	icon = {
		drawing = false,
	},
	label = {
		padding_left = 0,
		string = "0",
	},
	background = {
		drawing = false,
		padding_right = 0,
		padding_left = 0,
	},
})
--
Bar.add("bracket", {
	"/mic\\..*/",
}, {
	background = {
		drawing = true,
	},
})

Bar.add("item", {
	width = settings.bar_gap,
	background = {
		drawing = false,
	},
})

local function animate_slider_width(width)
	Bar.animate("tanh", 30.0, function()
		mic_slider:set({ slider = { width = width } })
	end)
end

mic_icon:subscribe("mouse.entered", function()
	animate_slider_width(100)
end)

mic_icon:subscribe("mouse.exited.global", function()
	animate_slider_width(0)
end)

mic_label:subscribe("mouse.entered", function()
	animate_slider_width(100)
end)

mic_slider:subscribe("mouse.clicked", function(env)
	Bar.exec("osascript -e 'set volume input volume " .. env["PERCENTAGE"] .. "'")
end)

mic_icon:subscribe("mouse.clicked", function()
	Bar.exec([[
osascript -e "set ivol to input volume of (get volume settings)
if ivol > 0 then
    set volume input volume 0
else
    set volume input volume 100
end if"
  ]])
end)

local function update()
	Bar.exec([[osascript -e "input volume of (get volume settings)"]], function(value)
		local icon = icons.mic.off
		local volume = 0

		if value == nil or string.find(value, "missing value") then
			volume = 0
		else
			volume = tonumber(value) or 0
		end
		if volume > 0 then
			icon = icons.mic.on
		end
		mic_label:set({
			label = {
				string = volume,
			},
		})
		mic_icon:set({
			icon = {
				string = icon,
			},
		})

		mic_slider:set({ slider = { percentage = volume } })
	end)
end

mic_slider:subscribe({ "routine", "system_woke" }, function()
	update()
end)
--
