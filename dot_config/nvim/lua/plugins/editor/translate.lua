return {

  "uga-rosa/translate.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>T", "", desc = "+translate", mode = { "n", "x" } },
    { "<leader>Tc", "", desc = "+chinese", mode = { "n", "x" } },
    { "<leader>Te", "", desc = "+english", mode = { "n", "x" } },
    {
      "<leader>Tcc",
      "<CMD>Translate ZH<CR>",
      desc = "Default",
      mode = { "n", "x" },
    },
    {
      "<leader>Tcf",
      "<CMD>Translate ZH -output=floating<CR>",
      desc = "Floating",
      mode = { "n", "x" },
    },

    {
      "<leader>Tcs",
      "<CMD>Translate ZH -output=split<CR>",
      desc = "Split",
      mode = { "n", "x" },
    },

    {
      "<leader>Tci",
      "<CMD>Translate ZH -output=insert<CR>",
      desc = "Insert",
      mode = { "n", "x" },
    },
    {
      "<leader>Tcr",
      "<CMD>Translate ZH -output=replace<CR>",
      desc = "Replace",
      mode = { "n", "x" },
    },
    {
      "<leader>Tee",
      "<CMD>Translate EN<CR>",
      desc = "Default",
      mode = { "n", "x" },
    },
    {
      "<leader>Tef",
      "<CMD>Translate EN -output=floating<CR>",
      desc = "Floating",
      mode = { "n", "x" },
    },
    {
      "<leader>Tes",
      "<CMD>Translate EN -output=split<CR>",
      desc = "Split",
      mode = { "n", "x" },
    },
    {
      "<leader>Tei",
      "<CMD>Translate EN -output=insert<CR>",
      desc = "Insert",
      mode = { "n", "x" },
    },
    {
      "<leader>Ter",
      "<CMD>Translate EN -output=replace<CR>",
      desc = "Replace",
      mode = { "n", "x" },
    },
  },
  opts = {
    default = {
      command = "translate_shell",
    },
    preset = {
      output = {
        split = {
          append = true,
        },
      },
    },
  },
}
