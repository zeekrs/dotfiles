return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "typos-lsp")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {},
      },
      setup = {
        -- https://github.com/tekumara/typos-lsp/blob/main/docs/neovim-lsp-config.md
        typos_lsp = function(_, opts)
          opts.init_options = {
            config = "~/.config/typos.toml",
            diagnosticSeverity = "Hint",
          }
          return false
        end,
      },
    },
  },
}
