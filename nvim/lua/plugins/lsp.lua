return {
  "neovim/nvim-lspconfig",
  config = function()
    local cfg = vim.lsp.config

    local capabilities =
      require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local on_attach = function(_, bufnr)
      local map = function(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
      end

      map("n", "gd", vim.lsp.buf.definition)
      map("n", "K", vim.lsp.buf.hover)
      map("n", "gr", vim.lsp.buf.references)
      map("n", "<leader>rn", vim.lsp.buf.rename)
      map("n", "<leader>ca", vim.lsp.buf.code_action)
    end

    -- ======================
    --  LSP SERVER DEFINITIONS
    -- ======================

    cfg.lua_ls = {
      cmd = { "lua-language-server" },
      filetypes = { "lua" },
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    }

    cfg.pyright = {
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      on_attach = on_attach,
      capabilities = capabilities,
    }

    cfg.cssls = {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less" },
      on_attach = on_attach,
      capabilities = capabilities,
    }

    cfg.jdtls = {
      cmd = { "jdtls" },
      filetypes = { "java" },
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- ======================
    --  ENABLE SERVERS
    -- ======================
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("pyright")
    vim.lsp.enable("cssls")
    vim.lsp.enable("jdtls")
  end,
}

