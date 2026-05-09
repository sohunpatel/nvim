-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Autocmd to load treesitter if the parser is installed
vim.api.nvim_create_autocmd({ "FileType", "BufReadPost" }, {
  group = vim.api.nvim_create_augroup("TreesitterAutomation", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local ft = vim.bo[bufnr].filetype

    -- 1. Get the corresponding treesitter language name
    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- 2. Check if the parser is installed
    local has_parser, _ = pcall(vim.treesitter.get_parser, bufnr, lang)

    -- 3. Check if highlight queries exist for this language
    local has_queries = vim.treesitter.query.get(lang, "highlights") ~= nil

    if has_parser and has_queries then
      vim.treesitter.start(bufnr, lang)
      -- Optional: Log success to your log file
      -- vim.lsp.log.info("Treesitter started for: " .. lang)
    else
      -- Optional: Log failure to help debug missing parsers
      -- vim.lsp.log.warn("Treesitter skip: " .. lang .. " (Parser: " .. tostring(has_parser) .. ")")
    end
  end,
})

-- Close the current buffer
vim.keymap.set("n", "<leader>x", "<CMD> bw <CR>", { desc = "Close current buffer" })

-- Keybinding to restart LSP servers
vim.keymap.set("n", "<leader>lr", "<CMD> LspRestart <CR>", { desc = "Restart LSP" })

-- vim:ts=2 sts=2 sw=2 et
