local prefix = "<leader>C"
return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  opts = {
    api_key_cmd = "op read op://Personal/OpenAI/credential --no-newline",
    api_host_cmd = "echo -n https://api.lmtchina.com",
  },
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
      mod = { "n", "v" },
    },
    {
      prefix .. "g",
      "<cmd>ChatGPTRun grammar_correction<CR>",
      desc = "Grammar Correction",
      mod = { "n", "v" },
    },
    {
      prefix .. "t",
      "<cmd>ChatGPTRun translate<CR>",
      desc = "Translate",
      mod = { "n", "v" },
    },
    {
      prefix .. "k",
      "<cmd>ChatGPTRun keywords<CR>",
      desc = "Keywords",
      mod = { "n", "v" },
    },
    {
      prefix .. "d",
      "<cmd>ChatGPTRun docstring<CR>",
      desc = "Docstring",
      mod = { "n", "v" },
    },
    {
      prefix .. "a",
      "<cmd>ChatGPTRun add_tests<CR>",
      desc = "Add Tests",
      mod = { "n", "v" },
    },
    {
      prefix .. "o",
      "<cmd>ChatGPTRun optimize_code<CR>",
      desc = "Optimize Code",
      mod = { "n", "v" },
    },
    {
      prefix .. "s",
      "<cmd>ChatGPTRun summarize<CR>",
      desc = "Summarize",
      mod = { "n", "v" },
    },
    {
      prefix .. "f",
      "<cmd>ChatGPTRun fix_bugs<CR>",
      desc = "Fix Bugs",
      mod = { "n", "v" },
    },
    {
      prefix .. "x",
      "<cmd>ChatGPTRun explain_code<CR>",
      desc = "Explain Code",
      mod = { "n", "v" },
    },
    {
      prefix .. "r",
      "<cmd>ChatGPTRun roxygen_edit<CR>",
      desc = "Roxygen Edit",
      mod = { "n", "v" },
    },
    {
      prefix .. "l",
      "<cmd>ChatGPTRun code_readability_analysis<CR>",
      desc = "Code Readability Analysis",
      mod = { "n", "v" },
    },
  },
}
