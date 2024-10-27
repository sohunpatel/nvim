local M = {}
local utils = require "core.utils"

-- export on_attach & capabilites for custom lspconfigs
M.on_attach = function(client, bufnr)
  -- utils.load_mappings("lspconfig", { buffer = bufnr })

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M .capabilites = vim.lsp.protocol.make_client_capabilities()

M.capabilites.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require "lspconfig"

local servers = { "clangd", "cmake", "harper_ls", "jinja_lsp", "lua_ls", "ruff", "rust_analyzer", "typst_lsp", "verible", "veryl_ls" }

lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        autopep8 = {
          enabled = false
        },
        mypy = {
          enabled = false
        }
      }
    }
  }
}

lspconfig.harper_ls.setup {
  settings = {
    ["harper-ls"] = {
      linters = {
        spell_check = true,
        spelled_numbers = false,
        an_a = true,
        sentence_capitalization = true,
        unclosed_quotes = true,
        wrong_quotes = true,
        long_sentences = true,
        repeated_words = true,
        spaces = true,
        matcher = true,
        correct_number_suffix = true,
        number_suffix_capitalization = true,
        multiple_sequential_pronouns = true,
        linking_verbs = true,
        avoid_curses = true,
        terminating_conjunctions = true
      }
    }
  },
  filetypes = {
    "markdown",
    "typst"
  }
}

vim.filetype.add {
  extension = {
    jinja = 'jinja',
    jinja2 = 'jinja',
    j2 = 'jinja',
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilites = capabilites,
  }
end

return M
