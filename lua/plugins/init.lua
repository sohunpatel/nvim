-- All plugins have lazy=true be default, to load a plugin on startup set lazy=false
-- List of all default plguins & their definitions
local plugins = {

  -- library for asynchronous functions
  "nvim-lua/plenary.nvim",

  -- vscode theme
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("vscode").setup()
      require("vscode").load()
    end,
    lazy = false,
    priority = 1000
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
    tag = "v0.9.2",
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

  -- terminal
  {
    "NvChad/nvterm",
    init = function()
      require("core.utils").load_mappings "nvterm"
    end,
    config = function(_, opts)
      require("nvterm").setup(opts)
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
    opts = function()
      return require("plugins.configs.neogen")
    end,
    init = function()
      require("core.utils").load_mappings "neogen"
    end,
    config = function()
      require("neogen").setup(opts)
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
        options = {
          theme = "vscode"
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
    keys = {
      {
        "<leader>fs",
        function() require("rip-substitute").sub() end,
        mode = { "n", "x" },
        desc = "RipGrep substitution"
      },
    },
  },

  -- UI stuff
  "stevearc/dressing.nvim",

  -- Better search highlighting
  {
    "kevinhwang91/nvim-hlslens",
    lazy = false,
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
  }
}

local config = require("core.config")

require("lazy").setup(plugins, config.lazy_nvim)
