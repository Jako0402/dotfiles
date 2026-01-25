return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
				go = { "goimports", "gofumpt" },
			},
		})

		-- Format on save (Autocmd)
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				conform.format({ bufnr = args.buf })
			end,
		})

		-- Shortcut: Alt + Shift + F (Visual and Normal mode)
		vim.keymap.set({ "n", "v" }, "<A-S-f>", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			})
		end, { desc = "Format file or range (Alt+Shift+F)" })
	end,
}
