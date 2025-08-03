return {
	{
		"akinsho/bufferline.nvim",
		dependenceis = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("bufferline").setup({})

			vim.keymap.set("n", "<tab>", "<CMD> BufferLineCycleNext <CR>", { desc = "Switch to next buffer" })
			vim.keymap.set("n", "<S-tab>", "<CMD> BufferLineCyclePrev <CR>", { desc = "Switch to next buffer" })
			vim.keymap.set("n", "<leader>X", "<CMD> BufferLineCloseOthers <CR>", { desc = "Close all other buffers" })
		end,
	},
}
