local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

Bar.add("item", {
	width = settings.bar_gap,
	background = {
		drawing = false,
	},
})

local volume_icon = Bar.add("item", "volume.icon", {
	width = 40,
	icon = {
		string = icons.volume._0,
		color = colors.blue,
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

local volume_slider = Bar.add("slider", "volume.slider", 100, {
	updates = true,
	label = { drawing = false },
	icon = { drawing = false },
	background = { drawing = false, padding_left = settings.item_gap, padding_right = settings.item_gap },
	slider = {
		highlight_color = colors.blue,
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

local volume_label = Bar.add("item", "volume.label", {
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
	"/volume\\..*/",
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
		volume_slider:set({ slider = { width = width } })
	end)
end

volume_icon:subscribe("mouse.entered", function()
	animate_slider_width(100)
end)

volume_icon:subscribe("mouse.exited.global", function()
	animate_slider_width(0)
end)

volume_label:subscribe("mouse.entered", function()
	animate_slider_width(100)
end)

--
volume_slider:subscribe("volume_change", function(env)
	local value = tonumber(env.INFO)
	local icon = icons.volume._0
	if value > 60 then
		icon = icons.volume._100
	elseif value > 30 then
		icon = icons.volume._66
	elseif value > 10 then
		icon = icons.volume._33
	elseif value > 0 then
		icon = icons.volume._10
	end

	volume_icon:set({
		icon = {
			string = icon,
		},
	})

	volume_label:set({
		label = {
			string = value,
		},
	})

	volume_slider:set({ slider = { percentage = value } })
end)
--
volume_slider:subscribe("mouse.clicked", function(env)
	Bar.exec("osascript -e 'set volume output volume " .. env["PERCENTAGE"] .. "'")
end)

volume_icon:subscribe("mouse.clicked", function()
	Bar.exec([[
osascript -e "set ovol to output muted of (get volume settings)
if ovol is false then
    set volume with output muted
else
    set volume without output muted
end if"
  ]])
end)
