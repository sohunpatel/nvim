return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },

        config = function()
            require("lualine").setup({
                sections = {
                    lualine_b = { "branch", "diff", "diagnostics", {
                        require("nvim-possession").status,
                        cond = function()
                            return require("nvim-possession").status() ~= nil
                        end
                    }, "overseer" }
                }
            })
        end
    }
}
