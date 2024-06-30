return {
  {
    "jackMort/ChatGPT.nvim",
    opts = {
      openai_params = {
        model = "gpt-4o",
      },
      openai_edit_params = {
        model = "gpt-4o",
      },
    },
    keys = {
      {
        "<leader>G",
        "",
        desc = "GPT",
        mode = { "n", "v" },
      },
      {
        "<leader>Gc",
        "<cmd>ChatGPT<CR>",
        desc = "Chat GPT",
      },
      {
        "<leader>Ge",
        "<cmd>ChatGPTEditWithInstruction<CR>",
        desc = "Edit with instruction",
        mode = { "n", "v" },
      },
      {
        "<leader>Gg",
        "<cmd>ChatGPTRun grammar_correction<CR>",
        desc = "Grammar Correction",
        mode = { "n", "v" },
      },
      {
        "<leader>Gt",
        "<cmd>ChatGPTRun translate<CR>",
        desc = "Translate",
        mode = { "n", "v" },
      },
      {
        "<leader>Gk",
        "<cmd>ChatGPTRun keywords<CR>",
        desc = "Keywords",
        mode = { "n", "v" },
      },
      {
        "<leader>Gd",
        "<cmd>ChatGPTRun docstring<CR>",
        desc = "Docstring",
        mode = { "n", "v" },
      },
      {
        "<leader>Ga",
        "<cmd>ChatGPTRun add_tests<CR>",
        desc = "Add Tests",
        mode = { "n", "v" },
      },
      {
        "<leader>Go",
        "<cmd>ChatGPTRun optimize_code<CR>",
        desc = "Optimize Code",
        mode = { "n", "v" },
      },
      {
        "<leader>Gs",
        "<cmd>ChatGPTRun summarize<CR>",
        desc = "Summarize",
        mode = { "n", "v" },
      },
      {
        "<leader>Gf",
        "<cmd>ChatGPTRun fix_bugs<CR>",
        desc = "Fix Bugs",
        mode = { "n", "v" },
      },
      {
        "<leader>Gx",
        "<cmd>ChatGPTRun explain_code<CR>",
        desc = "Explain Code",
        mode = { "n", "v" },
      },
      {
        "<leader>Gr",
        "<cmd>ChatGPTRun roxygen_edit<CR>",
        desc = "Roxygen Edit",
        mode = { "n", "v" },
      },
      {
        "<leader>Gl",
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        desc = "Roxygen Edit",
        mode = { "n", "v" },
      },
    },
  },
}
