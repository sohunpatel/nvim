return {
	{
		"pwntester/octo.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"ibhagwan/fzf-lua",
		},

		config = function()
			require("octo").setup({
				picker = "fzf-lua",
			})

			-- Octo keymaps
			vim.keymap.set("n", "<leader>oi", "<cmd> Octo issue list <CR>", { desc = "List all issues" })
			vim.keymap.set("n", "<leader>op", "<cmd> Octo pr list <CR>", { desc = "List all prs" })
		end,
	},
}
