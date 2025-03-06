local settings = require("settings")
local colors = require("colors")
local brew = Bar.add("item", {
	position = "right",
	icon = {
		string = "􀐛",
		color = colors.blue,
		font = {
			family = settings.font.nerd,
		},
	},
	label = {
		font = {
			family = settings.font.numbers,
		},
		string = "?",
	},
})

local function update()
	Bar.exec([[ brew outdated | wc -l | tr -d ' ' ]], function(res)
		local count = tonumber(res)
		local color = colors.green
		if count > 30 then
			color = colors.red
		elseif count > 10 then
			color = colors.yellow
		end

		brew:set({
			label = {
				color = color,
				string = count,
			},
		})
	end)
end

brew:subscribe({ "brew_update" }, function()
	update()
end)
