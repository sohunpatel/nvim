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

local servers = { "clangd", "cmake", "jinja_lsp", "lua_ls", "ruff", "rust_analyzer", "verible", "veryl_ls" }

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
