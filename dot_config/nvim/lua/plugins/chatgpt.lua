local prefix = "<leader>C"
return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        [prefix] = { name = "+chat gpt" },
      },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        prefix .. "c",
        "<cmd>ChatGPT<CR>",
        desc = "Chat GPT",
      },
      {
        prefix .. "e",
        "<cmd>ChatGPTEditWithInstruction<CR>",
        desc = "Edit with instruction",
        mode = { "n", "v" },
      },
      {
        prefix .. "g",
        "<cmd>ChatGPTRun grammar_correction<CR>",
        desc = "Grammar Correction",
        mode = { "n", "v" },
      },
      {
        prefix .. "t",
        "<cmd>ChatGPTRun translate<CR>",
        desc = "Translate",
        mode = { "n", "v" },
      },
      {
        prefix .. "k",
        "<cmd>ChatGPTRun keywords<CR>",
        desc = "Keywords",
        mode = { "n", "v" },
      },
      {
        prefix .. "d",
        "<cmd>ChatGPTRun docstring<CR>",
        desc = "Docstring",
        mode = { "n", "v" },
      },
      {
        prefix .. "a",
        "<cmd>ChatGPTRun add_tests<CR>",
        desc = "Add Tests",
        mode = { "n", "v" },
      },
      {
        prefix .. "o",
        "<cmd>ChatGPTRun optimize_code<CR>",
        desc = "Optimize Code",
        mode = { "n", "v" },
      },
      {
        prefix .. "s",
        "<cmd>ChatGPTRun summarize<CR>",
        desc = "Summarize",
        mode = { "n", "v" },
      },
      {
        prefix .. "f",
        "<cmd>ChatGPTRun fix_bugs<CR>",
        desc = "Fix Bugs",
        mode = { "n", "v" },
      },
      {
        prefix .. "x",
        "<cmd>ChatGPTRun explain_code<CR>",
        desc = "Explain Code",
        mode = { "n", "v" },
      },
      {
        prefix .. "r",
        "<cmd>ChatGPTRun roxygen_edit<CR>",
        desc = "Roxygen Edit",
        mode = { "n", "v" },
      },
      {
        prefix .. "l",
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        desc = "Roxygen Edit",
        mode = { "n", "v" },
      },
    },
  },
}
