local settings = require("settings")

local airpods = Bar.add("item", {
	updates = true,
	drawing = false,
	update_freq = 1,
})

local left = Bar.add("item", "airpods.left", {
	drawing = false,
	icon = {
		string = "􀲎",
	},
	label = {
		string = "?",
		font = {
			family = settings.font.numbers,
		},
	},
})

local right = Bar.add("item", "airpods.right", {
	drawing = false,
	icon = {
		string = "􀲍",
	},
	label = {
		string = "?",
		font = {
			family = settings.font.numbers,
		},
	},
})
local case = Bar.add("item", "airpods.case", {
	drawing = false,
	icon = {
		string = "􀹫",
	},
	label = {
		string = "?",
		font = {
			family = settings.font.numbers,
		},
	},
})

local function update()
	Bar.exec(
		[[system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null | jq -rc '.SPBluetoothDataType[0].device_connected[] | select ( .[] | .device_minorType == "Headphones")' | jq '.[]']],
		function(res)
			if res == "" or res == "\n" then
				left:set({ drawing = false })
				right:set({ drawing = false })
				case:set({ drawing = false })
			else
				local has_left = res["device_batteryLevelLeft"]
				local has_right = res["device_batteryLevelRight"]
				local has_case = res["device_batteryLevelCase"]

				if has_left then
					left:set({
						drawing = true,
						label = {
							string = (res["device_batteryLevelLeft"] or "?"):gsub("%%$", ""),
							padding_right = (has_right or has_case) and 0 or settings.item_padding,
						},
					})
				else
					left:set({ drawing = false })
				end
				if has_right then
					right:set({
						drawing = true,
						icon = {
							padding_left = has_left and 0 or settings.item_padding,
						},
						label = {
							string = (res["device_batteryLevelRight"] or "?"):gsub("%%$", "") or "?",
							padding_right = has_case and 0 or settings.item_padding,
						},
					})
				else
					right:set({ drawing = false })
				end

				if has_case then
					case:set({
						drawing = true,
						icon = {
							padding_left = (has_left or has_right) and 0 or settings.item_padding,
						},
						label = { string = (res["device_batteryLevelCase"] or "?"):gsub("%%$", "") },
					})
				else
					case:set({ drawing = false })
				end
			end
		end
	)
end

Bar.add("bracket", {
	"/airpods\\..*/",
}, {
	background = {
		drawing = true,
	},
})

airpods:subscribe({ "routine", "system_woke" }, function()
	update()
end)
