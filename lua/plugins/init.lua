-- All plugins have lazy=true be default, to load a plugin on startup set lazy=false
-- List of all default plguins & their definitions
local plugins = {

  -- library for asynchronous functions
  "nvim-lua/plenary.nvim",

  -- gruvbox theme
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = false
      vim.cmd.colorscheme('gruvbox-material')
    end
  },

  -- gui notifications
  {
    "rcarriga/nvim-notify",
    priority = 1000,
    config = function()
    end
  },

  -- -- indentation guides
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "User FilePost",
  --   lazy = false,
  --   opts = function()
  --     return require("plugins.configs.others").blankline
  --   end,
  --   config = function(_, opts)
  --     require("core.utils").load_mappings "blankline"
  --     require("ibl").setup(opts)
  --   end,
  -- },

  -- better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = function()
      return require("plugins.configs.others").gitsigns
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },

  -- actual lsp stuff
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    -- event = "User FilePost",
    init = function ()
      require("core.utils").load_mappings "lspconfig"
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("plugins.configs.others").luasnip(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "plugins.configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Commnet toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
    },
    init = function()
      require("core.utils").load_mappings "comment"
    end,
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    init = function()
      require("core.utils").load_mappings "nvimtree"
    end,
    opts = function()
      return require "plugins.configs.nvimtree"
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },

  -- fzf picker window
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = function()
      return require "plugins.configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      -- for _, ext in ipairs(opts.extensions_list) do
      --   telescope.load_extension(ext)
      -- end
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    init = function()
      require("core.utils").load_mappings "whichkey"
    end,
    cmd = "WhichKey",
    config = function(_, opts)
      require("which-key").setup(opts)
    end,
  },

  -- leave modes faster
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- better formatter than native formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "plugins.configs.conform"
    end,
  },

  -- guess the appropriate indentation
  {
    "nmac427/guess-indent.nvim",
    lazy = false,
    init = function()
      require("guess-indent").setup()
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    lazy = false
  },

  -- diagnostic viewers
  {
    "folke/trouble.nvim",
    dependencies = {
      -- add todo comments to diagnostics
      "folke/todo-comments.nvim"
    },
    config = function()
      require("trouble").setup()
    end,
  },

  -- annotation generator
  {
    "danymat/neogen",
    lazy = false,
    -- event = "User FilePost",
    dependencies = "nvim-treesitter/nvim-treesitter",
    init = function()
      require("core.utils").load_mappings "neogen"
    end,
    config = function()
      require("neogen").setup({
        enabled = true,
        languages = {
          python = {
            template = {
              annotation_convention = "numpydoc" -- for a full list of annotation_conventions, see supported-languages below,
            }
          },
    }
      })
    end
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        sections = {
          lualine_b = { "branch", "diff", "diagnostics", require('plugins.configs.ghn').formatter }
        }
      })
    end
  },

  -- dashboard
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("core.utils").load_mappings "bufferline"
      require("bufferline").setup(opts)
    end
  },

  -- github integration
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    lazy = false,
    init = function()
      require("core.utils").load_mappings("octo")
    end,
    config = function()
      require("octo").setup()
    end
  },

  -- ripgrep substitution
  {
    "chrisgrieser/nvim-rip-substitute",
  },

  -- UI stuff
  "stevearc/dressing.nvim",

  -- Better search highlighting
  {
    "kevinhwang91/nvim-hlslens",
    lazy = false,
    config = function()
      require("hlslens").setup()
    end
  },

  -- LSP dev info
  {
    "j-hui/fidget.nvim",
    lazy = false,
  },

  -- better command wilder
  -- TODO: configure wilder
  {
    "gelguy/wilder.nvim",
    lazy = false
  },

  -- debug adapter protocol
  {
    "mfussenegger/nvim-dap"
  },

  -- zen mode
  {
    "folke/zen-mode.nvim",
    keys = {
      {
        "<leader>z",
        function()
          require("zen-mode").toggle({
            window = {
              width = 0.85
            }
          })
        end,
        mode = { "n", "x" },
        desc = "Enter zen mode"
      }
    }
  },

  -- github notifications indicator
  {
    "rlch/github-notifications.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- "nvim-notify/notify.nvim"
    }
  },

  -- asciidoc preview
  {
    "tigion/nvim-asciidoc-preview",
    ft = { "asciidoc" },
    build = "cd server && npm install",
    opts = {
      server = {
        converter = "cmd"
      }
    }
  },

  -- veryl plugin
  {
    "veryl-lang/veryl.vim",
    ft = "veryl"
  }
}

local config = require("core.config")

require("lazy").setup(plugins, config.lazy_nvim)
vim.notify = require("notify")
