local settings = require("settings")
local icons = require("icons")
local colors = require("colors")
local icon_map = require("icon_map")

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

local layout = Bar.add("item", "layout", {
	position = "right",
	icon = {
		string = icons.layout.bsp,
		color = colors.mauve,
		font = {
			family = settings.font.nerd,
		},
		padding_right = settings.item_padding,
		padding_left = settings.item_padding,
	},
	background = {
		padding_left = 0,
		padding_right = 0,
		drawing = false,
	},
	label = { drawing = false },
})

local apps = {}
-- init stack apps  max for 5 if greater than it will show nearly 5 items
for i = 1, 5, 1 do
	apps[i] = Bar.add("item", "stack." .. 6 - i, {
		drawing = false,
		position = "right",
		icon = {
			padding_left = i == 5 and settings.item_padding or settings.item_gap,
			padding_right = settings.item_gap,
			string = icons["apple"],
			color = colors.subtext0,
			font = {
				family = settings.app_font,
			},
			highlight_color = colors.lavender,
		},
		background = {
			drawing = false,
			padding_right = 0,
			padding_left = 0,
		},
		label = {
			drawing = false,
		},
	})
end

local function set_apps(index, indices)
	Bar.exec(
		[[yabai -m query --windows --space  | jq -r '[.[] | select(.["stack-index"] > 0)] | sort_by(.["stack-index"])']],
		function(windows)
			for i = 1, #indices do
				local current_index = indices[i]
				for _, window in ipairs(windows) do
					if window["stack-index"] == current_index then
						apps[6 - i]:set({
							icon = { string = icon_map[window["app"]], highlight = current_index == index },
						})
						apps[6 - i]:subscribe("mouse.clicked", function()
							Bar.exec([[yabai -m window --focus stack.]] .. current_index)
						end)
					end
				end
			end
		end
	)
end

local function set_layout()
	Bar.exec([[yabai -m query --spaces --display | jq -r '.[] | select(."has-focus")']], function(space)
		local type = space.type
		local icon = icons.layout.bsp
		local color = colors.mauve
		if type == "stack" then
			icon = icons.layout.stack
			color = colors.maroon
		elseif type == "float" then
			icon = icons.layout.float
			color = colors.teal
		end
		layout:set({
			icon = { string = icon, color = color },
			-- label = { string = type },
		})
	end)
end

layout:subscribe({ "space_change", "layout_changed", "window_focus", "front_app_switched" }, function()
	set_layout()
	Bar.exec([[yabai -m query --windows --window | jq '.["stack-index"]']], function(index)
		index = tonumber(index)
		if index == 0 then
			Bar.animate("tanh", 10, function()
				Bar.set("/stack\\..*/", { drawing = false })
			end)
			layout:set({
				icon = {
					padding_left = settings.item_padding,
				},
			})
		else
			layout:set({
				icon = {
					padding_left = settings.item_gap,
				},
			})
			Bar.exec([[yabai -m query --windows --window stack.last | jq '.["stack-index"]']], function(last_index)
				last_index = tonumber(last_index)
				if last_index == nil then
					last_index = 0
				end
				local indices = {}
				if last_index > 5 then
					for i = -2, 2 do
						local idx = (index + i - 1) % last_index + 1
						table.insert(indices, idx)
					end
				else
					for i = 1, last_index do
						table.insert(indices, i)
					end
				end
				if #indices > 0 then
					set_apps(index, indices)
				end
				Bar.animate("tanh", 10, function()
					for i = 1, 5 do
						Bar.set("stack." .. i, { drawing = i <= #indices })
					end
				end)
			end)
		end
	end)
end)

layout:subscribe("mouse.clicked", function()
	Bar.exec([[yabai -m query --spaces --display | jq -r '.[] | select(."has-focus")']], function(space)
		print(space.type)
		local type = space.type
		if type == "stack" then
			Bar.exec([[yabai -m space --layout float]], function()
				Bar.trigger("layout_changed")
			end)
		elseif type == "float" then
			Bar.exec([[yabai -m space --layout bsp]], function()
				Bar.trigger("layout_changed")
			end)
		else
			Bar.exec([[yabai -m space --layout stack]], function()
				Bar.trigger("layout_changed")
			end)
		end
	end)
end)

Bar.add("bracket", {
	layout.name,
	"/stack\\..*/",
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
