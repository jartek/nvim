return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"olimorris/neotest-rspec",
			"stevearc/overseer.nvim",
		},
		config = function()
			require("overseer").setup()
			local neotest = require("neotest")
			neotest.setup({
				adapters = {
					require("neotest-rspec")({
						rspec_cmd = function()
							return {
								"docker-compose",
								"exec",
								"-it",
								"api",
								"bundle",
								"exec",
								"rspec",
							}
						end,
						formatter = "json",
						transform_spec_path = function(path)
							local prefix = require("neotest-rspec").root(path)
							return string.sub(path, string.len(prefix) + 2, -1)
						end,
						results_path = "tmp/rspec.output",
					}),
				},
				output = {
					open_on_run = true,
				},
				floating = {
					border = "rounded",
					max_height = 0.6,
					max_width = 0.6,
					options = {},
				},
				consumers = {
					overseer = require("neotest.consumers.overseer"),
				},
				overseer = {
					enabled = true,
					force_default = true,
				},
			})
			vim.keymap.set("n", "<leader>tl", function()
				neotest.run.run()
			end, { desc = "Run nearest test" })
			vim.keymap.set("n", "<leader>tf", function()
				neotest.run.run(vim.fn.expand("%"))
			end, { desc = "Run current file" })
			-- Optional: Open the output in a floating window
			vim.keymap.set("n", "<leader>to", function()
				neotest.output.open({ enter = true, auto_close = true, last_run = true })
			end, { desc = "Show test output" })
			-- Optional: Jump to next/previous failed test
			vim.keymap.set("n", "[t", function()
				neotest.jump.prev({ status = "failed" })
			end, { desc = "Jump to previous failed test" })
			vim.keymap.set("n", "]t", function()
				neotest.jump.next({ status = "failed" })
			end, { desc = "Jump to next failed test" })
		end,
	},
}
