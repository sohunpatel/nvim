-- This module should contain all of the options for the theme that I am currently using.

return {
	{
		"Mofiqul/vscode.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			vim.g.gruvbox_material_enable_italic = false
			vim.cmd.colorscheme("vscode")
		end,
	},
}
