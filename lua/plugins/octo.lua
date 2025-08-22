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
			vim.keymap.set("n", "<leader>oi", "<cmd> Octo issue list <CR>", { desc = "[o]cto list all [i]ssues" })
			vim.keymap.set("n", "<leader>op", "<cmd> Octo pr list <CR>", { desc = "[o]cto list all [p]rs" })
            vim.keymap.set("n", "<leader>on", "<cmd> Octo notification list <CR>", { desc = "[o]cto list [n]otifications" })
		end,
	},
}
