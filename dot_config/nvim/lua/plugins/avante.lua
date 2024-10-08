return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  opts = {
    -- add any opts here
    provider = "openai",
    openai = {
      endpoint = os.getenv("OPENAI_API_HOST") .. "/v1",
    },
  },
  build = ":AvanteBuild", -- This is optional, recommended tho. Also note that this will block the startup for a bit since we are compiling bindings in Rust.
  dependencies = {
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to setup it properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
