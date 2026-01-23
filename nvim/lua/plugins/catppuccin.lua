return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				auto_integrations = true,
			})

			-- Set the colorscheme here
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
}
