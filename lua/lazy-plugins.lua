-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.

	-- modular approach: using `require 'path.name'` will
	-- include a plugin definition from file lua/path/name.lua

	-- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- place them in the correct locations.

	require("plugins.debug"),
	require("plugins.indent_line"),
	require("plugins.autopairs"),

	-- Editor plugins
	require("plugins.lspconfig"),
	require("plugins.blink-cmp"),
	require("plugins.treesitter"),
	require("plugins.conform"),
    require("plugins.comment"),

	-- UI plugins
	require("plugins.theme"),
	require("plugins.todo-comments"),
	require("plugins.neo-tree"),
	require("plugins.bufferline"),

	-- Utilities
	require("plugins.which-key"),
	require("plugins.fzf"),
	require("plugins.sessions"),

	-- Git integration
	require("plugins.gitsigns"),
	require("plugins.neogit"),
	require("plugins.octo"),

    -- AI
    require("plugins.copilot")
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
