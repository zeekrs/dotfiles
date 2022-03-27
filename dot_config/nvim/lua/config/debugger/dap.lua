local icons = require("icons")

vim.fn.sign_define("DapBreakpoint", { text = icons.ui.Bug, texthl = "DiagnosticSignError", linehl = "", numhl = "" })
