return {
    {
        "zbirenbaum/copilot.lua",
        requires = {
            "copilotlsp-nvim/copilot-lsp",
        },
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        event = "BufEnter",
        opts = {
            window = {
                layout = "float",
            },
        },
        config = function()
            require("CopilotChat").setup({
                window = {
                    layout = "float",
                },
            })

            -- CopilotChat keymaps
            vim.keymap.set("n", "<leader>acq", function()
                local input = vim.fn.input("Quick Chat: ")
                if input ~= "" then
                    require("CopilotChat").ask(input, {
                        selection = require("CopilotChat.select").buffer,
                    })
                end
            end, { desc = "CopilotChat - Quick Chat" })
            vim.keymap.set("n", "<leader>act", function()
                require("CopilotChat").toggle()
            end, { desc = "CopilotChat - Toggle Chat" })
            vim.keymap.set(
                "v",
                "<leader>acd",
                "<CMD> CopilotChatDocs <CR>",
                { desc = "CopilotCaht - Add documentation" }
            )
        end,
    },
}
