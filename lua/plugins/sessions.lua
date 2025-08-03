return {
	{
		"gennaro-tedesco/nvim-possession",
		dependencies = {
			"ibhagwan/fzf-lua",
		},
		config = function()
			require("nvim-possession").setup({
				autoload = true,
				autosave = true,
			})

			-- Nvim Possession keymaps
			vim.keymap.set("n", "<leader>pl", require("nvim-possession").list, { desc = "List possession sessions" })
			vim.keymap.set(
				"n",
				"<leader>pn",
				require("nvim-possession").new,
				{ desc = "Create new possession sessions" }
			)
			vim.keymap.set(
				"n",
				"<leader>pu",
				require("nvim-possession").update,
				{ desc = "Update possession sessions" }
			)
			vim.keymap.set(
				"n",
				"<leader>pd",
				require("nvim-possession").delete,
				{ desc = "Delete possession sessions" }
			)
		end,
	},
}
