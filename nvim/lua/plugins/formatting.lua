return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				css = { "prettier" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				require("conform").format({ async = false })
			end,
		})
	end,
}
