local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = require("packer")

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})
-- Install your plugins here
return packer.startup(function(use)
	--Basic
	use({ "lewis6991/impatient.nvim", config = [[require('impatient')]] }) -- it is recommened to put impatient.nvim before any other plugins
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("kyazdani42/nvim-web-devicons")
	use("famiu/bufdelete.nvim")

	-- WakeTiime
	use("wakatime/vim-wakatime")

	-- Colorschema
	use("rebelot/kanagawa.nvim")

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "hrsh7th/cmp-emoji", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "tzachar/cmp-tabnine", after = "nvim-cmp", run = "./install.sh" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" },
		},
		config = [[require('config.completion')]],
	})

	use({ "windwp/nvim-autopairs", config = [[require('config.autopairs')]] }) -- Autopairs, integrates with both cmp and treesitter

	-- LSP
	use({ "neovim/nvim-lspconfig", config = [[require('config.lsp')]] })
	use({ "ray-x/lsp_signature.nvim" }) --Show function signature when you type
	use({ "RRethy/vim-illuminate" }) -- automatically highlighting other uses of the current word under the cursor
	use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
	use("folke/trouble.nvim") -- A pretty list for showing diagnostics, references, telescope results, quickfixand location lists to help you solve all the trouble your code is causing.
	use("b0o/SchemaStore.nvim") --json-ls schema store

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", config = [[require('config.telescope')]] })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-media-files.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use({ "ahmedkhalf/project.nvim", config = [[require('config.project')]] })

	--Threesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require('config.treesitter')]] })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use({ "p00f/nvim-ts-rainbow" })
	use("windwp/nvim-ts-autotag")
	use("romgrk/nvim-treesitter-context")
	use("mizlan/iswap.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	--Comment
	use({ "numToStr/Comment.nvim", config = [[require('config.comment')]] })

	--Git
	use({ "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] }) -- Super fast git decorations implemented purely in lua/teal.

	use({ "kyazdani42/nvim-tree.lua", config = [[require('config.nvim-tree')]] }) -- A File Explorer For Neovim Written In Lua

	use({ "akinsho/bufferline.nvim", config = [[require('config.bufferline')]] }) -- A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.

	use({ "nvim-lualine/lualine.nvim", config = [[require('config.lualine')]] }) --  A blazing fast and easy to configure Neovim statusline written in Lua.

	use({ "lukas-reineke/indent-blankline.nvim", config = [[require('config.indentline')]] }) -- This plugin adds indentation guides to all lines (including empty lines).

	use({ "goolord/alpha-nvim", config = [[require('config.alpha')]] }) -- This plugin adds indentation guides to all lines (including empty lines).

	use({ "folke/which-key.nvim", config = [[require('config.which-key')]] }) -- displays a popup with possible key bindings of the command you started typing

	-- Terminal
	use({ "akinsho/toggleterm.nvim", config = [[require('config.toggleterm')]] }) -- A neovim plugin to persist and toggle multiple terminals during an editing session

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
