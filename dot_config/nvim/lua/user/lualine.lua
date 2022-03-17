local colors = require("kanagawa.colors").setup()

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
}

-- diff_source from gitsigns
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
-- flatten null-ls support sources
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

-- components

local start_block = {
	function()
		return "▊"
	end,
	padding = { left = 0, right = 1 }, -- We don't need space before this
	color = { bg = colors.bg_light0 },
}

local mode = {
	function()
		return ""
	end,
	padding = { right = 1 },
	color = { bg = colors.bg_light0 },
}

local filename = {
	"filename",
	cond = conditions.buffer_not_empty,
	color = { gui = "bold", bg = colors.bg_light0 },
}

local location = { "location", color = { gui = "bold" } }

local progress = { "progress" }

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
}
local diff = {
	"diff",
	source = diff_source,
	symbols = { added = "  ", modified = " ", removed = " " },
	cond = conditions.hide_in_width,
}

local branch = {
	"b:gitsigns_head",
	icon = " ",
	color = { gui = "bold" },
	cond = conditions.hide_in_width,
}

local lsp = {
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
}

local treesitter = {
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return ""
		end
		return ""
	end,
	color = { fg = colors.springGreen },
	cond = conditions.hide_in_width,
}

local filesize = {
	"filesize",
	cond = conditions.buffer_not_empty,
}
local encoding = {
	"o:encoding", -- option component same as &encoding in viml
	fmt = string.upper, -- I'm not sure why it's upper case either ;)
	cond = conditions.hide_in_width,
	color = { bg = colors.bg_light0, gui = "bold" },
}

local fileformat = {
	"fileformat",
	fmt = string.upper,
	icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	color = { bg = colors.bg_light0, gui = "bold" },
}

-- end with  block
local end_block = {
	function()
		return "▊"
	end,
	padding = { left = 1, right = 0 }, -- We don't need space before this

	color = { bg = colors.bg_light0 },
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {},
		lualine_b = { start_block, mode, filename },
		lualine_c = { location, progress, diagnostics },
		lualine_x = { diff, branch, lsp, treesitter, filesize },
		lualine_y = { encoding, fileformat, end_block },
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
})
