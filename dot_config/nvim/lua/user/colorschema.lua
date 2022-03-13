-- vim.g.tokyonight_transparent = true

-- vim.g.tokyonight_lualine_bold = true
--
-- vim.cmd([[colorscheme tokyonight]])

-- local nightfox = require("nightfox")
--
-- nightfox.setup({
-- 	fox = "nordfox", -- change the colorscheme to use nordfox
-- 	transparent = true,
-- 	styles = {
-- 		comments = "italic", -- change style of comments to be italic
-- 		keywords = "bold", -- change style of keywords to be bold
-- 		functions = "italic,bold", -- styles can be a comma separated list
-- 	},
-- 	inverse = {
-- 		match_paren = true, -- inverse the highlighting of match_parens
-- 	},
-- 	colors = {
-- 		red = "#FF000", -- Override the red color for MAX POWER
-- 		bg_alt = "#000000",
-- 	},
-- 	hlgroups = {
-- 		TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
-- 		LspCodeLens = { bg = "#000000", style = "italic" },
-- 	},
-- })
--
-- nightfox.load()

require("kanagawa").setup({
	undercurl = true, -- enable undercurls
	commentStyle = "italic",
	functionStyle = "NONE",
	keywordStyle = "italic",
	statementStyle = "bold",
	typeStyle = "NONE",
	variablebuiltinStyle = "italic",
	specialReturn = true, -- special highlight for the return keyword
	specialException = true, -- special highlight for exception handling keywords
	transparent = true, -- do not set background color
	dimInactive = true, -- dim inactive window `:h hl-NormalNC`
	colors = {},
	overrides = {},
})
vim.cmd([[colorscheme kanagawa]])
