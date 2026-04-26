local colors = require("colors")
local sources = {
	"com.apple.keylayout.ABC",
	"com.apple.inputmethod.SCIM.ITABC",
}

local inputsource = Bar.add("alias", "控制中心,com.apple.TextInputMenuAgent", {
	position = "right",
	alias = {
		color = colors.text,
	},
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

inputsource:subscribe("mouse.clicked", function()
	Bar.exec("macism", function(current)
		local currentIndex = 1
		for i, source in ipairs(sources) do
			if string.find(current, source) then
				currentIndex = i
				break
			end
		end
		local nextIndex = currentIndex + 1
		nextIndex = nextIndex > #sources and 1 or nextIndex
		Bar.exec("macism " .. sources[nextIndex])
	end)
end)
