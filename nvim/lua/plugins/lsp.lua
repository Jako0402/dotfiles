return {
	"neovim/nvim-lspconfig",
	config = function()
		local cfg = vim.lsp.config
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		-- Add borders to all floating windows (Hover and Diagnostics)
		local border = "rounded"
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
		vim.diagnostic.config({ float = { border = border } })

		local on_attach = function(_, bufnr)
			local map = function(mode, lhs, rhs)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
			end

			-- VS Code Style Keybinds
			map("n", "<F12>", vim.lsp.buf.definition)
			map("n", "gd", vim.lsp.buf.definition)
			map("n", "<F2>", vim.lsp.buf.rename)
			map("n", "<C-.>", vim.lsp.buf.code_action)
			map("n", "gr", vim.lsp.buf.references)

			-- Custom Hover Mapping (Ctrl+h)
			map("n", "<C-h>", vim.lsp.buf.hover)

			-- Diagnostic specific popup (Optional: Ctrl+e for Errors)
			map("n", "<C-e>", vim.diagnostic.open_float)
		end

		-- Server Configurations
		cfg.lua_ls = {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = { Lua = { diagnostics = { globals = { "vim" } } } },
		}

		cfg.pyright = { on_attach = on_attach, capabilities = capabilities }
		cfg.cssls = { on_attach = on_attach, capabilities = capabilities }
		cfg.jdtls = { on_attach = on_attach, capabilities = capabilities }

		-- Go Support
		cfg.gopls = {
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				gopls = {
					analyses = { unusedparams = true },
					staticcheck = true,
					gofumpt = true,
				},
			},
		}

		-- Enable Servers (Neovim 0.11+)
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pyright")
		vim.lsp.enable("cssls")
		vim.lsp.enable("jdtls")
		vim.lsp.enable("gopls")
	end,
}
