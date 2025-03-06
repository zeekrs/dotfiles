local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local vpn = Bar.add("item", "vpn", {
	position = "right",
	icon = {
		string = icons.vpn,
		color = colors.red,
	},
	label = {
		font = {
			family = settings.nerd_font,
			size = settings.icon_size,
			style = settings.font.style_map["Bold"],
		},
		string = "",
		color = colors.red,
	},
	update_freq = 3,
})

vpn:subscribe("mouse.clicked", function()
	Bar.exec("scutil --nc list | grep '^\\*' | head -n 1", function(vpn_info)
		if vpn_info ~= "" then
			local vpn_name = vpn_info:match('"([^"]+)"')
			if vpn_name then
				local apple_script = string.format(
					[[
					tell application "System Events"
						tell current location of network preferences
							if current configuration of service "%s" is not connected then
								connect service "%s"
							else
								disconnect service "%s"
							end if
						end tell
					end tell
				]],
					vpn_name,
					vpn_name,
					vpn_name
				)

				-- 执行AppleScript
				Bar.exec(string.format("osascript -e '%s'", apple_script))
			end
		end
	end)
end)

vpn:subscribe({ "routine", "system_woke" }, function()
	Bar.exec("scutil --nc list | grep '^\\*' | grep Connected", function(connected)
		if connected ~= "" then
			vpn:set({
				label = {
					string = "",
				},
			})
		else
			vpn:set({
				label = {
					string = "",
				},
			})
		end
	end)
end)
