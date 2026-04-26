return {
	default_toggle = "on",
	ethernet = "en1",
	icon_size = 16,
	text_size = 14,
	icons = "sf-symbols", -- alternatively available: NerdFont
	app_font = "sketchybar-app-font",
	item_padding = 16,
	item_gap = 4,
	bar_gap = 6,

	-- This is a font configuration for SF Pro and SF Mono (installed manually)
	font = {
		default = "SF Pro", -- Used for default
		text = "SF Pro", -- Used for text
		mono = "SF Mono", -- Used for mono
		nerd = "JetBrainsMono Nerd Font",
		numbers = "SF Mono", -- Used for numbers
		-- Unified font style map
		style_map = {
			["Regular"] = "Regular",
			["Semibold"] = "Semibold",
			["Bold"] = "Bold",
			["Heavy"] = "Heavy",
			["Black"] = "Black",
		},
	},
	
	-- Alternative nerd font reference (used in vpn.lua)
	nerd_font = "JetBrainsMono Nerd Font",
}
