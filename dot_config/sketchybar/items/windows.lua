local settings = require("settings")
local icons = require("icons")
local colors = require("colors")
local icon_map = require("icon_map")

local window_observer = Bar.add("item", {
	drawing = false,
	updates = true,
})

local windows = {}
-- init windows  max for 9 if greater than it will show nearly 9 items
for i = 1, 9, 1 do
	windows[i] = Bar.add("item", "window." .. 10 - i, {
		drawing = false,
		position = "center",
		icon = {
			padding_left = settings.item_gap,
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
		},
		label = {
			drawing = false,
		},
	})
end

local function set_windows(index, indices, list)
	for i = 1, #indices do
		local current_index = indices[i]
		local window = list[current_index]
		windows[10 - i]:set({
			icon = { string = icon_map[window["app"]], highlight = current_index == index },
		})
		windows[10 - i]:subscribe("mouse.clicked", function()
			print("focus ..........")
			Bar.exec([[yabai -m window --focus ]] .. window["id"])
		end)
	end
end

window_observer:subscribe(
	{ "space_change", "layout_changed", "window_focus", "front_app_switched", "space_windows_change" },
	function()
		Bar.exec(
			[[yabai -m query --windows --space | jq -r '[.[] | select(.["has-ax-reference"] and .["can-move"])] | sort_by(.["id"])']],
			function(list)
				local length = tonumber(#list)

				local index = 1

				for i, window in ipairs(list) do
					if window["has-focus"] then
						index = i
					end
				end

				local indices = {}
				if length > 9 then
					for i = -4, 4 do
						local idx = (index + i - 1) % length + 1
						table.insert(indices, idx)
					end
				else
					for i = 1, length do
						table.insert(indices, i)
					end
				end
				if #indices > 0 then
					set_windows(index, indices, list)
				end
				Bar.animate("tanh", 10, function()
					for i = 1, 5 do
						Bar.set("window." .. i, { drawing = i <= #indices })
					end
				end)
			end
		)
	end
)
