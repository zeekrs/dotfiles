local prefix = "<leader>cc"

--- Get all the changes in the git repository
---@param staged? boolean
---@return string
local function get_git_diff(staged)
  local cmd = staged and "git diff --staged" or "git diff"
  local handle = io.popen(cmd)
  if not handle then
    return ""
  end

  local result = handle:read("*a")
  handle:close()
  return result
end

local prompts = {
  -- Code related prompts
  Explain = "Please explain how the following code works.",
  Review = "Please review the following code and provide suggestions for improvement.",
  Tests = "Please explain how the selected code works, then generate unit tests for it.",
  Refactor = "Please refactor the following code to improve its clarity and readability.",
  FixCode = "Please fix the following code to make it work as intended.",
  BetterNamings = "Please provide better names for the following variables and functions.",
  Documentation = "Please provide documentation for the following code.",
  SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
  SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
  -- Text related prompts
  Summarize = "Please summarize the following text.",
  Spelling = "Please correct any grammar and spelling errors in the following text.",
  Wording = "Please improve the grammar and wording of the following text.",
  Concise = "Please rewrite the following text to make it more concise.",
}

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        [prefix] = { name = "+copilot chat" },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      show_help = "yes", -- Show help text for CopilotChatInPlace, default: yes
      prompts = prompts,
      debug = false, -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = "no", -- Disable extra information (e.g: system prompt) in the response.
      hide_system_prompt = "yes",
      language = "English", -- Copilot answer language settings when using default prompts. Default language is English.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
    },
    build = function()
      vim.notify("Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim.")
    end,
    event = "VeryLazy",
    keys = {
      {
        prefix .. "h",
        function()
          require("CopilotChat.code_actions").show_help_actions()
        end,
        desc = "Help actions",
      },
      {
        prefix .. "p",
        function()
          require("CopilotChat.code_actions").show_prompt_actions()
        end,
        desc = "Prompt actions",
      },
      {
        prefix .. "p",
        ":lua require('CopilotChat.code_actions').show_prompt_actions(true)<CR>",
        mode = "x",
        desc = "Prompt actions",
      },
      {
        prefix .. "c",
        function()
          local input = vim.fn.input("Ask Copilot: ")
          if input ~= "" then
            vim.cmd("CopilotChat " .. input)
          end
        end,
        mode = "n",
        desc = "Ask input",
      },
      {
        prefix .. "c",
        function()
          local input = vim.fn.input("Ask Copilot(V): ")
          if input ~= "" then
            vim.cmd("CopilotChatVisual " .. input)
          end
        end,
        mode = "x",
        desc = "Ask input(V)",
      },
      { prefix .. "e", "<cmd>CopilotChatExplain<cr>", desc = "Explain code" },
      { prefix .. "t", "<cmd>CopilotChatTests<cr>", desc = "Generate tests" },
      { prefix .. "r", "<cmd>CopilotChatReview<cr>", desc = "Review code" },
      { prefix .. "R", "<cmd>CopilotChatRefactor<cr>", desc = "Refactor code" },
      { prefix .. "n", "<cmd>CopilotChatBetterNamings<cr>", desc = "Better Naming" },
      {
        prefix .. "v",
        ":CopilotChatVisual",
        mode = "x",
        desc = "Open in vertical split",
      },
      {
        prefix .. "x",
        ":CopilotChatInPlace<cr>",
        mode = "x",
        desc = "Run in-place code",
      },
      {
        prefix .. "m",
        function()
          local diff = get_git_diff()
          if diff ~= "" then
            vim.fn.setreg('"', diff)
            vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
          end
        end,
        desc = "Generate commit message for all changes",
      },
      {
        prefix .. "M",
        function()
          local diff = get_git_diff(true)
          if diff ~= "" then
            vim.fn.setreg('"', diff)
            vim.cmd("CopilotChat Write commit message for the change with commitizen convention.")
          end
        end,
        desc = "Generate commit message for staged changes",
      },
      {
        prefix .. "q",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            vim.cmd('normal! ggVG"*y')
            vim.cmd("CopilotChat " .. input)
          end
        end,
        desc = "Quick chat",
      },
      { prefix .. "d", "<cmd>CopilotChatDebugInfo<cr>", desc = "Debug Info" },
      { prefix .. "f", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "Fix Diagnostic" },
      { prefix .. "l", "<cmd>CopilotChatReset<cr>", desc = "Clear buffer and chat history" },
      { prefix .. "v", "<cmd>CopilotChatVsplitToggle<cr>", desc = "Toggle Vsplit" },
    },
  },
}
