return {
    {
        "rootiest/nvim-updater.nvim",
        config = function()
            require("nvim_updater").setup({
                source_dir = "~/.local/src/neovim",
                build_type = "RelWithDebInfo",
                branch = "release-0.11",
                check_for_updates = true,
                notify_updates = true,
                default_keymap = false
            })
        end,
    }
}
