return {
    {
        "stevearc/overseer.nvim",

        config = function()
            local overseer = require("overseer")
            overseer.setup({
                task_list = {
                    direction = "right"
                }
            })

            -- Keymappings
            vim.keymap.set("n", "<leader>tr", function()
                local input = vim.fn.input("Run: ")
                if input ~= "" then
                    overseer.run_template({ name = input })
                end
            end, { desc = "Overseer: run task" })
            vim.keymap.set("n", "<leader>tl", function()
                local available = overseer.list_tasks({ unique = true, recent_first = true })
                local names = {}
                for _, task in ipairs(available) do
                    if task.name then
                        table.insert(names, task.name)
                    end
                end
                require("fzf-lua").fzf_exec(names)
            end, { desc = "Overseer: list available tasks" })
            vim.keymap.set("n", "<leader>tt", function()
                overseer.toggle({})
            end, { desc = "Overseer: toggle status" })
            vim.keymap.set("n", "<leader>tj", function()
                local tasks = overseer.list_tasks({ recent_first = true })
                if vim.tbl_isempty(tasks) then
                    vim.notify("No tasks found", vim.log.levels.WARN)
                else
                    overseer.run_action(tasks[1], "restart")
                end
            end, { desc = "Overseer: restart last action" })

            -- Load my custom templats/providers
            local providers = require("plugins.custom")
            for _, provider in ipairs(providers) do
                overseer.register_template(provider)
            end
        end
    }
}
