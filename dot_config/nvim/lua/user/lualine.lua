local colors = require("kanagawa.colors").setup()
local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
}
local mode_color = function()
	-- auto change color according to neovims mode
	local mode_color = {
		n = colors.crystalBlue,
		i = colors.autumnGreen,
		v = colors.oniViolet,
		V = colors.oniViolet,
		c = colors.boatYellow2,
		no = colors.crystalBlue,
		s = colors.sakuraPink,
		S = colors.sakuraPink,
		[""] = colors.sakuraPink,
		ic = colors.lightBlue,
		R = colors.sakuraPink,
		Rv = colors.sakuraPink,
		cv = colors.crystalBlue,
		ce = colors.crystalBlue,
		r = colors.waveRed,
		rm = colors.waveRed,
		["r?"] = colors.waveRed,
		["!"] = colors.crystalBlue,
		t = colors.crystalBlue,
	}
	return { fg = mode_color[vim.fn.mode()] }
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end
local function null_ls_support_source_names(fileType, method)
	local sources = require("null-ls.sources")
	local availableSources = sources.get_available(fileType)
	local source_names = {}
	for _, source in ipairs(availableSources) do
		for _method in pairs(source.methods) do
			if method == _method then
				table.insert(source_names, source.name)
			end
		end
	end
	return source_names
end

local config = {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = mode_color, -- Sets highlighting of component
	padding = { left = 0, right = 1 }, -- We don't need space before this
})

ins_left({
	-- mode component
	function()
		return ""
	end,
	color = mode_color,
	padding = { right = 1 },
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.oniViolet, gui = "bold" },
})

ins_left({
	-- filesize component
	"filesize",
	cond = conditions.buffer_not_empty,
})

ins_left({ "location", color = { gui = "bold" } })

ins_left({ "progress" })

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
	diagnostics_color = {
		color_error = { fg = colors.samuraiRed },
		color_warn = { fg = colors.roninYellow },
		color_info = { fg = colors.waveAqua1 },
	},
})

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left({
	function()
		return "%="
	end,
})

-- Add components to right sections
ins_right({
	"diff",
	source = diff_source,
	symbols = { added = "  ", modified = " ", removed = " " },
	diff_color = {
		added = { fg = colors.autumnGreen },
		modified = { fg = colors.autumnYellow },
		removed = { fg = colors.autumnRed },
	},
	cond = conditions.hide_in_width,
})

ins_right({
	"b:gitsigns_head",
	icon = " ",
	color = { gui = "bold" },
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		local msg = "No Active Lsp"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		local client_names = {}
		-- add client
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
				table.insert(client_names, client.name)
			end
		end

		-- null-ls support
		local null_ls = require("null-ls")

		-- add formatter
		local supported_formaters = null_ls_support_source_names(buf_ft, null_ls.methods.FORMATTING)
		vim.list_extend(client_names, supported_formaters)

		-- add linters
		local supported_linters = null_ls_support_source_names(buf_ft, null_ls.methods.DIAGNOSTICS)
		vim.list_extend(client_names, supported_linters)

		return "[" .. table.concat(client_names, " ") .. "]"
	end,
	icon = " LSP:",
	color = { gui = "bold" },
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return ""
		end
		return ""
	end,
	color = { fg = colors.springGreen },
	cond = conditions.hide_in_width,
})

ins_right({
	function()
		if not vim.api.nvim_buf_get_option(0, "expandtab") then
			return "Tab size: " .. vim.api.nvim_buf_get_option(0, "tabstop") .. " "
		end
		local size = vim.api.nvim_buf_get_option(0, "shiftwidth")
		if size == 0 then
			size = vim.api.nvim_buf_get_option(0, "tabstop")
		end
		return "Spaces: " .. size .. " "
	end,
	cond = conditions.hide_in_width,
	color = {},
})
ins_right({
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { fg = colors.springGreen, gui = "bold" },
})

ins_right({
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { fg = colors.springGreen, gui = "bold" },
})

ins_right({
	function()
		return "▊"
	end,
	color = mode_color,
	padding = { left = 1 },
})

require("lualine").setup(config)
