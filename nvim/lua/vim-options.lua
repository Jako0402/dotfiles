vim.wo.number = true
vim.wo.relativenumber = true

-- Tab / Indentation settings
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4 -- Number of spaces that a <Tab> counts for while performing editing
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true -- Convert all tabs to spaces

-- Toggle diagnostic
vim.keymap.set("n", "<leader>dt", function()
	if vim.diagnostic.is_enabled() then
		vim.diagnostic.enable(false)
	else
		vim.diagnostic.enable(true)
	end
end, { desc = "Toggle Diagnostics" })
