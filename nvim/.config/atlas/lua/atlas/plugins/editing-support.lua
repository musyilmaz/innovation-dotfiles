return {
  {
    "chrisgrieser/nvim-chainsaw",
    event = "VeryLazy",
    opts = {
      marker = "❗",
      logStatements = {
        objectLog = {
          -- repurposing objectLog for debugging via AppleScript notification
          sh = [[osascript -e "display notification \"%s %s\" with title \"$%s\""]],
        },
      },
    },
    keys = {
      {
        "<leader>ll",
        function()
          require("chainsaw").variableLog()
        end,
        mode = { "n", "x" },
        desc = "󰸢 variable",
      },
      {
        "<leader>lo",
        function()
          require("chainsaw").objectLog()
        end,
        mode = { "n", "x" },
        desc = "󰸢 object",
      },
      {
        "<leader>lm",
        function()
          require("chainsaw").messageLog()
        end,
        desc = "󰸢 message",
      },
      {
        "<leader>lt",
        function()
          require("chainsaw").timeLog()
        end,
        desc = "󰸢 time",
      },

      {
        "<leader>lr",
        function()
          require("chainsaw").removeLogs()
        end,
        desc = "󰹝 remove logs",
      },
    },
    config = function()
      require("chainsaw").setup({
        logStatements = {
          variableLog = {
            javascript = 'console.log("{{marker}} {{filename}}:{{lnum}} -- {{var}}:", {{var}});',
          },
          objectLog = {
            javascript = 'console.log("{{marker}} {{filename}}:{{lnum}} -- {{var}}:", JSON.stringify({{var}}, null, 2))',
          },
        },
      })
    end,
  },
}
