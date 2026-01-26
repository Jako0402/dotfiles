return {
	"neovim/nvim-lspconfig",
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
		local border = "rounded"

		-- UI Customization
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
		vim.diagnostic.config({ float = { border = border } })

		-- Global Keybinds via LspAttach
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf
				local map = function(mode, lhs, rhs)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
				end

				-- VS Code Style Keybinds
				map("n", "<F12>", vim.lsp.buf.definition)
				map("n", "gd", vim.lsp.buf.definition)
				map("n", "<F2>", vim.lsp.buf.rename)
				map("n", "<C-.>", vim.lsp.buf.code_action)
				map("n", "gr", vim.lsp.buf.references)
				map("n", "<C-h>", vim.lsp.buf.hover)
				map("n", "<C-e>", vim.diagnostic.open_float)
			end,
		})

		--- Server Specific Configurations ---

		-- Python
		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					lineLength = 100,
				},
			},
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			settings = { Lua = { diagnostics = { globals = { "vim" } } } },
		})

		-- Go
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = { unusedparams = true },
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		-- Others
		vim.lsp.config("cssls", {})
		vim.lsp.config("jdtls", {})

		-- Enable all servers
		vim.lsp.enable({ "ruff", "ty", "lua_ls", "cssls", "jdtls", "gopls" })
	end,
}
