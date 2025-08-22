return {
    {
        "danymat/neogen",
        config = function()
            require("neogen").setup({})

            vim.keymap.set("n", "<leader>df", function() require("neogen").generate({ type = "func" }) end,
                { desc = "Generate function documentation" })
            vim.keymap.set("n", "<leader>dc", function() require("neogen").generate({ type = "class" }) end,
                { desc = "Generate class documentation" })
            vim.keymap.set("n", "<leader>dt", function() require("neogen").generate({ type = "type" }) end,
                { desc = "Generate type documentation" })
            vim.keymap.set("n", "<leader>dF", function() require("neogen").generate({ type = "file" }) end,
                { desc = "Generate file documentation" })
        end
    }
}
