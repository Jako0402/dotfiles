return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local cmp = require("cmp")

		cmp.setup({
			window = {
				completion = cmp.config.window.bordered({
					max_height = 10, -- Limit the popup to 10 rows
					side_padding = 1, -- Cleaner spacing
				}),
				documentation = cmp.config.window.bordered(),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<Esc>"] = cmp.mapping.abort(),
			}),

			-- 2. LIMIT SOURCE RESULTS
			sources = cmp.config.sources({
				{ name = "nvim_lsp", max_item_count = 15 },
				{ name = "buffer", max_item_count = 5 },
				{ name = "path", max_item_count = 5 },
			}),

			performance = {
				max_view_entries = 15,
			},
		})
	end,
}
