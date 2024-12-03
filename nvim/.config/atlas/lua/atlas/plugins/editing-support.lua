return {
  {
    "chrisgrieser/nvim-chainsaw",
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
			-- stylua: ignore start
			{"<leader>lb", function() require("chainsaw").beepLog() end, desc = "󰸢 beep" },
			{"<leader>ll", function() require("chainsaw").variableLog() end, mode = {"n", "x"}, desc = "󰸢 variable" },
			{"<leader>lo", function() require("chainsaw").objectLog() end, mode = {"n", "x"}, desc = "󰸢 object" },
			{"<leader>lm", function() require("chainsaw").messageLog() end, desc = "󰸢 message" },
			{"<leader>lt", function() require("chainsaw").timeLog() end, desc = "󰸢 time" },

			{"<leader>lr", function() require("chainsaw").removeLogs() end, desc = "󰹝 remove logs" },
      -- stylua: ignore end
    },
  },
}
