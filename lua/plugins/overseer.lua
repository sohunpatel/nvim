return {
    {
        "stevearc/overseer.nvim",

        config = function()
            require("overseer").setup({
                task_list = {
                    direction = "right"
                }
            })

            -- Keymappings
            vim.keymap.set("n", "<leader>tr", function()
                local input = vim.fn.input("Run: ")
                if input ~= "" then
                    require("overseer").run_template({ name = input })
                end
            end, { desc = "Overseer: run task" })
            vim.keymap.set("n", "<leader>tl", function()
                local available = require("overseer").list_tasks({ unique = true, recent_first = true })
            end, { desc = "Overseer: list available tasks" })
            vim.keymap.set("n", "<leader>tt", function()
                require("overseer").toggle({})
            end, { desc = "Overseer: toggle status" })
        end
    }
}
