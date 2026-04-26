local colors = require("colors")

local default_config = {
	height = 50,
	corner_radius = 16,
	border_width = 0,
	margin = 95,
	blur_radius = 0,
	position = "top",
	padding_left = 16,
	padding_right = 16,
	color = colors.base,
	topmost = false,
	sticky = true,
	font_smoothing = false,
	y_offset = 9,
	notch_width = 0,
}

local function initialize(name, config)
	Bar.set_bar_name(name)
	config = config or {}
	local _config = {}
	for k, v in pairs(default_config) do
		_config[k] = config[k] or v
	end
	Bar.bar(_config)
end
return initialize
