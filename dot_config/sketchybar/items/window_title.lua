local settings = require("settings")
local window_title = Bar.add("item", "window_title", {
	position = "center",
	icon = {
		drawing = false,
	},
	label = {
		padding_left = settings.item_padding,
	},
})

local callback = function(title)
	if #title > 64 then
		title = string.sub(title, 1, 64) .. "..."
	end
	window_title:set({
		label = title,
		background = {
			drawing = title ~= "",
		},
	})
end
window_title:subscribe({ "front_app_switched", "window_focus", "title_change" }, function()
	Bar.exec("yabai -m query --windows --window | jq -r '.title'", function(title)
		if title == "" then
			Bar.exec("yabai -m query --windows --window | jq -r '.app'", callback)
		else
			callback(title)
		end
	end)
end)
