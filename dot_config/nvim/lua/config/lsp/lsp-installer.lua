local lsp_installer = require("nvim-lsp-installer")

local servers = {
	"sumneko_lua",
	"jsonls",
	"tsserver",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found and not server:is_installed() then
		vim.notify("Installing " .. name)
		server:install()
	end
end

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
local config = require("config.lsp.lsp-config")
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = config.on_attach,
		capabilities = config.capabilities,
		handlers = config.handlers,
	}

	local loaded, setting = pcall(require, "config.lsp.settings." .. server.name)

	if loaded then
		opts = vim.tbl_deep_extend("force", setting, opts)
	end

	-- do not setup java
	if server.name == "jdtls" then
		return
	end

	-- (optional) Customize the options passed to the server
	-- if server.name == "tsserver" then
	--     opts.root_dir = function() ... end
	-- end

	-- This setup() function will take the provided server configuration and decorate it with the necessary properties
	-- before passing it onwards to lspconfig.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
