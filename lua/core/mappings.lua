-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- no to beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<ESC>"] = { "<cmd> noh <CR>", "Clear highlights" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    -- close buffer
    ["<leader>x"] = { "<cmd> bp|bd # <CR>", "Close buffer" },
    -- ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    -- format
    ["<leader>fm"] = {
      function()
        if (not require("conform").format()) 
        then
          vim.lsp.buf.format { async = true }
        end
      end,
      "LSP formatting",
    },

    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    -- format with conform

    -- split horizontally
    ["<leader>h"] = { "<cmd> split <CR>", "split horizontally" },
    -- split vertically
    ["<leader>v"] = { "<cmd> vsplit <CR>", "split vertically" },

    -- toggle Trouble window
    ["<leader>t"] = {
      function()
        require("trouble").toggle()
      end,
      "Toggle Trouble window",
    },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
    -- ["<leader>fj"] = { vim.lsp.buf.format, opts = { expr = true } }
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.lspconfig = {
  plugin = true,

  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

  n = {
    ["gi"] = {
      function()
        require("telescope.builtin").lsp_implementations()
      end,
      "LSP Implementation",
    },

    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "LSP definition",
    },

    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "LSP hover",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
    },

    ["gr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "LSP references",
    },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "Diagnostic setloclist",
    },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_actions()
      end,
      "LSP code action"
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  }
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>/"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "Toggle comment",
    },
  },

  v = {
    ["<leader>/"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
    ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },
    ["<leader>fn"] = { "<cmd> Telescope notify <CR>", "List all notifications" },
    ["<leader>fs"] = { "<cmd> Telescope lsp_document_symbols <CR>", "List document symbols" },
    ["<leader>fS"] = { "<cmd> Telescope lsp_document_symbols <CR>", "List workspace symbols" },
    ["<leader>fd"] = { "<cmd> Telescope diagnostics bufnr=0 <CR>", "Find diagnostics in this file" },

    -- git
    ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

    -- pick a hidden term
    -- ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

    -- theme switcher
    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    -- ["<A-h>"] = {
    --   function()
    --     require("nvterm.terminal").toggle "horizontal"
    --   end,
    --   "Toggle horizontal term",
    -- },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "Which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
  },
}

M.blankline = {
  plugin = true,

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    -- ["<leader>ph"] = {
    --   function()
    --     require("gitsigns").preview_hunk()
    --   end,
    --   "Preview hunk",
    -- },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

M.neogen = {
  plugin = true,

  n = {
    -- functions
    ["<leader>df"] = {
      function()
        require("neogen").generate({ type = "func" })
      end,
      "Generate function documentation"
    },
    -- classes
    ["<leader>dc"] = {
      function()
        require("neogen").generate({ type = "class" })
      end,
      "Generate class documentation"
    },
    -- type
    ["<leader>dt"] = {
      function()
        require("neogen").generate({ type = "type" })
      end,
      "Generate type documentation"
    },
    -- file
    ["<leader>dF"] = {
      function()
        require("neogen").generate({ type = "file" })
      end,
      "Generate file documentation"
    }
  }
}

M.bufferline = {
  plugin = true,

  n = {
    -- change buffers
    ["<tab>"] = { "<cmd> BufferLineCycleNext <CR>", "Switch tabs" },
    ["<S-tab>"] = { "<cmd> BufferLineCyclePrev <CR>", "Switch tabs" },
  }
}

M.octo = {
  plugin = true,

  n = {
    -- issues
    ["<leader>il"] = { 
      "<cmd> Octo issue list<CR>",
      "List all issues"
    },
    ["<leader>ic"] = {
      "<cmd> Octo issue close <CR>",
      "Close current issue"
    },
    ["<leader>ir"] = {
      "<cmd> Octo issue reopen <CR>",
      "Reopen issue"
    },
    ["<leader>ia"] = {
      "<cmd> Octo issue list assignee=sohun-arches <CR>",
      "List all issues assigned to me"
    },
    -- prs
    ["<leader>pl"] = { "<cmd> Octo pr list<CR>" },
    ["<leader>pc"] = { "<cmd> Octo pr close <CR>" },
    ["<leader>pr"] = { "<cmd> Octo pr reopen <CR>" },
  }
}

M.possession = {
  plugin = true,

  n = {
    ["<leader>sl"] = {
      function()
        require("nvim-possession").list()
      end,
      "List possesssion sessions"
    },
    ["<leader>sn"] = {
      function()
        require("nvim-possession").new()
      end,
      "Create new possesssion sessions"
    },
    ["<leader>su"] = {
      function()
        require("nvim-possession").update()
      end,
      "Update possesssion sessions"
    },
    ["<leader>sd"] = {
      function()
        require("nvim-possession").delete()
      end,
      "Delete possesssion sessions"
    },
  }
}

M.neogit = {
  plugin = true,

  n = {
    ["<leader>ns"] = {
      function()
        require("neogit").open()
      end,
      "Open neogit status"
    },
    ["<leader>nc"] = {
      function()
        require("neogit").open({ "commit" })
      end,
      "Open neogit commit"
    },
    ["<leader>nd"] = {
      function()
        require("neogit").open({ "diff" })
      end,
      "Open neogit diff view"
    }
  }
}

M.overseer = {
  plugin = true,

  n = {
    ["<leader>oi"] = {
      "<cmd> OverseerInfo<CR>",
      "Open Overseer Info"
    },
    ["<leader>oo"] = {
      "<cmd> OverseerOpen<CR>",
      "Open Overseer task list"
    },
    ["<leader>ol"] = {
      "<cmd> OverseerLoadBundle<CR>",
      "Open Overseer load task list"
    },
    ["<leader>os"] = {
      "<cmd> OverseerSaveBundle<CR>",
      "Open Overseer save task list"
    },
    ["<leader>oa"] = {
      "<cmd> OverseerQuickAction restart<CR>",
      "Restart last task"
    },
    ["<leader>or"] = {
      function()
        -- local pickers = require("telescope.pickers")
        -- local finders = require "telescope.finders"
        -- local conf = require("telescope.config").values
        -- local action_state = require('telescope.actions.state')
        --
        -- local prepare_task_list = function()
        --   local tasks = require("overseer").list_tasks()
        --   local names = {}
        --   vim.notify(string.format("length: %d", #tasks))
        --   for _, task in ipairs(tasks) do
        --     table.insert(names, task.name)
        --   end
        --   return names
        -- end
        --
        -- local target = function(opts)
        --   opts = opts or {}
        --   pickers.new(opts, {
        --     prompt_title = "run task",
        --     finder = finders.new_table {
        --       results = prepare_task_list()
        --     },
        --     sorter = conf.generic_sorter(opts),
        --     attach_mappings = function(prompt_bufnr, map)
        --       local action = function()
        --         local task = action_state.get_selected_entry().value
        --         require("overseer").run_template({ name = task })
        --       end
        --       map("i", "<CR>", action)
        --       return true
        --     end,
        --   }):find()
        -- end
        --
        -- target()

        local target = vim.fn.input("Task: ")
        require("overseer").run_template({ name = target })
      end,
      "Run task"
    },
  }
}

return M
