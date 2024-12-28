-- Split Join code block
return {
  "Wansmer/treesj",
  keys = {
    {
      "J",
      function()
        require("treesj").toggle()
      end,
      mode = { "n" },
      desc = "Toggle split/join",
    },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 65536,
  },
}
