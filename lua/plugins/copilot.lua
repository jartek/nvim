return {
	-- 	{
	-- 		"zbirenbaum/copilot.lua",
	-- 		event = "VeryLazy",
	-- 		enabled = true,
	-- 		config = function()
	-- 			require("copilot").setup({})
	-- 		end,
	-- 	},
	-- 	{
	-- 		"zbirenbaum/copilot-cmp",
	-- 		dependencies = { "onsails/lspkind.nvim" },
	-- 		config = function()
	-- 			require("copilot_cmp").setup()
	--
	-- 			local lspkind = require("lspkind")
	-- 			lspkind.init({
	-- 				symbol_map = {
	-- 					Copilot = "",
	-- 				},
	-- 			})
	--
	-- 			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
	-- 		end,
	-- 	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<Tab>",
					clear_suggestion = "<C-]>",
					accept_word = "<C-j>",
				},

				disable_inline_completion = false,
				disable_keymaps = false,
			})

			local lspkind = require("lspkind")
			lspkind.init({
				symbol_map = {
					Copilot = "",
					Supermaven = "",
				},
			})

			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
		end,
	},
}
