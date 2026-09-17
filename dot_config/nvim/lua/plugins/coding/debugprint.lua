return {
  "andrewferrier/debugprint.nvim",
  opts = {
    keymaps = {
      normal = {
        plain_below = "g?p",
        plain_above = "g?P",
        variable_below = "g?v",
        variable_above = "g?V",
        variable_below_alwaysprompt = nil,
        variable_above_alwaysprompt = nil,
        textobj_below = "g?o",
        textobj_above = "g?O",
        toggle_comment_debug_prints = "g?t",
        delete_debug_prints = "g?d",
      },
      visual = {
        variable_below = "g?v",
        variable_above = "g?V",
      },
    },
    commands = {
      toggle_comment_debug_prints = "ToggleCommentDebugPrints",
      delete_debug_prints = "DeleteDebugPrints",
    },
  },
  keys = {
    { "g?", "", mode = { "n", "x" }, desc = "+debug print" },
    { "g?p", mode = "n", desc = "Plain Below" },
    { "g?P", mode = "n", desc = "Plain Above" },
    { "g?v", mode = { "n", "x" }, desc = "Variable Below" },
    { "g?V", mode = { "n", "x" }, desc = "Variable Above" },
    { "g?o", mode = "n", desc = "Textobj Below" },
    { "g?O", mode = "n", desc = "Textobj Above" },
    { "g?t", mode = "n", desc = "Toggle Comment" },
    { "g?d", mode = "n", desc = "Delete DebugPrint" },
  },
  cmd = {
    "ToggleCommentDebugPrints",
    "DeleteDebugPrints",
  },
  version = "*",
}
