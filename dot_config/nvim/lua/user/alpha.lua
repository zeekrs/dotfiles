local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
	[[ _______             ____   ____.__         ]],
	[[ \      \   ____  ___\   \ /   /|__| _____  ]],
	[[ /   |   \_/ __ \/  _ \   Y   / |  |/     \ ]],
	[[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
	[[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
	[[        \/     \/                        \/ ]],
}

dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("u", "  Update plugins", ":PackerSync <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}
-- dashboard.section.footer.val = require("alpha.fortune")()

local handle = io.popen("fortune")
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune

require("alpha").setup(dashboard.config)
