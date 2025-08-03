return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("neogit").setup({})

			-- Neogit keymappings
			vim.keymap.set("n", "<leader>gs", require("neogit").open, { desc = "Open neogit status" })
			vim.keymap.set("n", "<leader>gc", function()
				require("neogit").open({ "commit" })
			end, { desc = "Open neogit commit" })
			vim.keymap.set("n", "<leader>gd", function()
				require("neogit").open({ "diff" })
			end, { desc = "Open neogit diffview" })
		end,
	},
}
