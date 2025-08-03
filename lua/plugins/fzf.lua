return {
	{ -- Fuzzy finder for multiple searches (files, keymaps, etc ...)
		"ibhagwan/fzf-lua",
		event = "VimEnter",
		dependencies = {
			-- Maybe switch to mini.icons?
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("fzf-lua").setup()

			-- Mappings for simple builting search tools
			vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "[s]earch [f]iles" })
			vim.keymap.set("n", "<leader>sk", require("fzf-lua").keymaps, { desc = "[s]earch [k]eymaps" })
			vim.keymap.set("n", "<leader>sg", require("fzf-lua").live_grep_native, { desc = "[s]earch by [g]rep" })
			vim.keymap.set(
				"n",
				"<leader>sd",
				require("fzf-lua").diagnostics_document,
				{ desc = "[s]earch [d]iagnostics" }
			)
			vim.keymap.set(
				"n",
				"<leader>sD",
				require("fzf-lua").diagnostics_workspace,
				{ desc = "[s]earch for workspace [D]iagnostics" }
			)
			vim.keymap.set("n", "<leader>sr", require("fzf-lua").resume, { desc = "[s]earch [r]esume" })
		end,
	},
}
