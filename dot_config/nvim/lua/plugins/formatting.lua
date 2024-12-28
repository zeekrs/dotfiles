local function find_config(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]
end

local function biome_or_prettier(bufnr)
  local has_biome_config = find_config(bufnr, { "biome.json", "biome.jsonc" })
  if has_biome_config then
    return { "biome-check", stop_after_first = true }
  end

  local has_prettier_config = find_config(bufnr, {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
  })
  if has_prettier_config then
    return { "prettier", stop_after_first = true }
  end

  -- Default to biome if no config is found
  return { "biome-check", stop_after_first = true }
end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettier")
      table.insert(opts.ensure_installed, "biome")
      table.insert(opts.ensure_installed, "black")
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      -- https://biomejs.dev/internals/language-support/
      formatters_by_ft = {
        ["javascript"] = biome_or_prettier,
        ["javascriptreact"] = biome_or_prettier,
        ["typescript"] = biome_or_prettier,
        ["typescriptreact"] = biome_or_prettier,
        ["json"] = biome_or_prettier,
        ["jsonc"] = biome_or_prettier,
        ["vue"] = { "prettier" },
        ["css"] = biome_or_prettier,
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = biome_or_prettier,
        ["handlebars"] = { "prettier" },
        ["python"] = { "black" },
        ["lua"] = { "stylua" },
        ["fish"] = { "fish_indent" },
        ["sh"] = { "shfmt" },
      },
    },
  },
}
