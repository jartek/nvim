return {
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		enabled = true,
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "onsails/lspkind.nvim" },
		config = function()
			require("copilot_cmp").setup()

			local lspkind = require("lspkind")
			lspkind.init({
				symbol_map = {
					Copilot = "",
				},
			})

			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
		end,
	},
}
