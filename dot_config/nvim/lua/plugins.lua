local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local packer_bootstrap

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
	use("tpope/vim-repeat") -- using the . command after a plugin map
	use("kyazdani42/nvim-web-devicons")
	use("famiu/bufdelete.nvim") ---allow you to delete a buffer without messing up your window layout.-
	use("antoinemadec/FixCursorHold.nvim") -- Fix CursorHold Performance

	use({ "rcarriga/nvim-notify", config = [[require('config.notify')]] }) -- A fancy, configurable, notification manager for NeoVim

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

	use({ "github/copilot.vim", config = [[require('config.copilot')]] }) -- Autopairs, integrates with both cmp and treesitter
	use({ "windwp/nvim-autopairs", config = [[require('config.autopairs')]] }) -- Autopairs, integrates with both cmp and treesitter

	-- LSP
	use({ "neovim/nvim-lspconfig", config = [[require('config.lsp')]] })
	use({ "williamboman/nvim-lsp-installer" }) --Neovim plugin that allows you to seamlessly install LSP servers locally
	use({ "ray-x/lsp_signature.nvim" }) --Show function signature when you type
	use({ "RRethy/vim-illuminate" }) -- automatically highlighting other uses of the current word under the cursor
	use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
	use("folke/trouble.nvim") -- A pretty list for showing diagnostics, references, telescope results, quickfixand location lists to help you solve all the trouble your code is causing.
	use("b0o/SchemaStore.nvim") --json-ls schema store
	use({ "simrat39/symbols-outline.nvim", config = [[require('config.symbols-outline')]] })
	--Rust
	use("simrat39/rust-tools.nvim")
	use("saecki/crates.nvim")
	-- Java
	use("mfussenegger/nvim-jdtls")

	--Threesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require('config.treesitter')]] })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use({ "p00f/nvim-ts-rainbow" })
	use("windwp/nvim-ts-autotag")
	-- use("romgrk/nvim-treesitter-context")
	use({ "mizlan/iswap.nvim", config = [[require('config.iswap')]] })
	use("JoosepAlviste/nvim-ts-context-commentstring")

	use({ "nvim-orgmode/orgmode", config = [[require('config.orgmode')]] })

	--Comment
	use({ "numToStr/Comment.nvim", config = [[require('config.comment')]] })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", config = [[require('config.telescope')]] })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-media-files.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use({ "ahmedkhalf/project.nvim", config = [[require('config.project')]] })

	use({ "windwp/nvim-spectre", config = [[require('config.spectre')]] }) -- Spectre find the enemy and replace them with dark power.

	--Git
	use({ "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] }) -- Super fast git decorations implemented purely in lua/teal.

	-- Integration
	use({ "kyazdani42/nvim-tree.lua", config = [[require('config.nvim-tree')]] }) -- A File Explorer For Neovim Written In Lua

	use({ "akinsho/bufferline.nvim", config = [[require('config.bufferline')]] }) -- A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.

	use({ "nvim-lualine/lualine.nvim", config = [[require('config.lualine')]] }) --  A blazing fast and easy to configure Neovim statusline written in Lua.

	use({ "SmiteshP/nvim-gps", config = [[require('config.gps')]] }) --  Take this handy dandy gps with you on your coding adventures and always know where you are!

	use({ "lukas-reineke/indent-blankline.nvim", config = [[require('config.indentline')]] }) -- This plugin adds indentation guides to all lines (including empty lines).

	use({ "goolord/alpha-nvim", config = [[require('config.alpha')]] }) -- This plugin adds indentation guides to all lines (including empty lines).

	use({ "folke/which-key.nvim", config = [[require('config.which-key')]] }) -- displays a popup with possible key bindings of the command you started typing

	-- Motion
	use({ "phaazon/hop.nvim", config = [[require('config.hop')]] }) --  allowing you to jump anywhere in a document with as few keystrokes as possible

	use({ "Mephistophiles/surround.nvim", config = [[require('config.surround')]] }) --   The plugin provides mappings to easily delete, change and add such surroundings in pairs
	use({ "nacro90/numb.nvim", config = [[require('config.numb')]] }) --   that peeks lines of the buffer in non-obtrusive way.

	use({ "monaqa/dial.nvim", config = [[require('config.dial')]] }) --  Extended increment/decrement plugin for Neovim
	use({ "norcalli/nvim-colorizer.lua", config = [[require('config.colorizer')]] }) --  A high-performance color highlighter for Neovim
	use({ "folke/zen-mode.nvim", config = [[require('config.zen-mode')]] }) --  opens the current buffer in a new full-screen floating window
	use({ "karb94/neoscroll.nvim", config = [[require('config.neoscroll')]] }) --  a smooth scrolling neovim plugin written in lua
	use({ "folke/todo-comments.nvim", config = [[require('config.todo-comments')]] }) -- highlight and search for todo comments like TODO, HACK, BUG in your code base.
	use({ "tversteeg/registers.nvim", config = [[require('config.registers')]] }) -- Show register content when you try to access it in Neovim. Written in Lua.

	-- Terminal
	use({ "akinsho/toggleterm.nvim", config = [[require('config.toggleterm')]] }) -- A neovim plugin to persist and toggle multiple terminals during an editing session

	-- Debugger
	use({ "michaelb/sniprun", run = "bash ./install.sh", config = [[require('config.sniprun')]] })

	use({
		"mfussenegger/nvim-dap",
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		config = [[require('config.debugger')]],
	})

	--Markdown
	use({

		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
