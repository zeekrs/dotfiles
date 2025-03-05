local colors = require("colors")
local media = Bar.add("item", {
	position = "right",
	icon = {
		drawing = false,
	},
	label = {
		padding_left = 16,
		string = "---",
		color = colors.red,
	},
})

media:subscribe("media_change", function(env)
	local app = env.INFO.app
	-- local state = env.INFO.state
	local title = env.INFO.title
	if string.find(app, "网易云音乐") then
		media:set({
			label = {
				string = title,
			},
		})
	end
end)
