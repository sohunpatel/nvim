return {
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"AndreM222/copilot-lualine",
		},

		config = function()
			require("lualine").setup({
				sections = {
					lualine_b = {
						"branch",
						"diff",
						"diagnostics",
						{
							require("nvim-possession").status,
							cond = function()
								return require("nvim-possession").status() ~= nil
							end,
						},
						"overseer",
					},
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = { "copilot", "encoding", "fileformat", "filetype" }, -- I added copilot here
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
