return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup({
			-- Use leader as prefix for all mappings
			mappings = {
				add = "<leader>sa", -- Add surrounding
				delete = "<leader>sd", -- Delete surrounding
				highlight = "<leader>sh", -- Highlight surrounding
				replace = "<leader>sr", -- Replace surrounding
				update_n_lines = "<leader>sn", -- Update `n_lines`

				-- Suffix versions
				add_line = "<leader>sa_",
				delete_line = "<leader>sd_",
				highlight_line = "<leader>sh_",
				replace_line = "<leader>sr_",
			},
		})

		-- Simple and easy statusline.
		--  You could remove this setup call if you don't like it,
		--  and try some other statusline plugin
		-- local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		-- statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		-- return "%2l:%-2v"
		-- end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
		--
		require("mini.move").setup( -- No need to copy this inside `setup()`. Will be used automatically.
			{
				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					-- Move visual selection in Visual mode. Changed to Alt + arrow keys.
					left = "<M-Left>",
					right = "<M-Right>",
					down = "<M-Down>",
					up = "<M-Up>",

					-- Move current line in Normal mode. Changed to Alt + arrow keys.
					line_left = "<M-Left>",
					line_right = "<M-Right>",
					line_down = "<M-Down>",
					line_up = "<M-Up>",
				},

				-- Options which control moving behavior
				options = {
					-- Automatically reindent selection during linewise vertical move
					reindent_linewise = true,
				},
			}
		)
	end,
}
