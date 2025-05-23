return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable "format_on_save lsp_fallback" for languages that don't
			-- have a well standardized coding style. You can add additional
			-- languages here or re-enable it for the disabled ones.
			local disable_filetypes = { c = true, cpp = true }
			local lsp_format_opt
			if disable_filetypes[vim.bo[bufnr].filetype] then
				lsp_format_opt = "never"
			else
				lsp_format_opt = "fallback"
			end
			return {
				timeout_ms = 500,
				lsp_format = lsp_format_opt,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "biome", stop_after_first = true },
			json = { "biome", stop_after_first = true },
			eruby = { "erb_formatter" },
			tf = { "tfmt" },
			terraform = { "tfmt" },
			hcl = { "tfmt" },
		},

		formatters = {
			erb_formatter = {
				command = "erb-formatter",
				args = { "--stdin" },
				stdin = true,
				timeout_ms = 5000,
			},
			tfmt = {
				-- Specify the command and its arguments for formatting
				command = "tofu",
				args = { "fmt", "-" },
				stdin = true,
			},
		},
		-- Add debug logging
		log_level = vim.log.levels.DEBUG,
	},
}
