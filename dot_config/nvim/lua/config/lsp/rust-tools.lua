local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local config = require("config.lsp.lsp-config")

local opts = {
	-- ... other configs

	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
	server = {
		on_attach = config.on_attach,
		capabilities = config.capabilities,
		handlers = config.handlers,
	},
}

require("rust-tools").setup(opts)
