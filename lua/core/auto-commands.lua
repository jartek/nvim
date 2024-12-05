-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 120 })
	end,
})

-- when opening a file, automatically lcd to its git repo ancestor
-- if already in a repo, behave somewhat like autocd
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(ev)
		-- Get the full path of the current buffer
		local buffile = vim.api.nvim_buf_get_name(ev.buf)
		if buffile == "" then
			return
		end -- Skip if buffer has no name

		-- Get current working directory
		local pwd = vim.fn.getcwd()

		-- Try to find git root, but don't error if not found
		local git_root = vim.fn.system(
			"git -C " .. vim.fn.escape(vim.fn.fnamemodify(buffile, ":p:h"), " ") .. " rev-parse --show-toplevel"
		)
		local is_git_repo = vim.v.shell_error == 0

		if is_git_repo then
			-- Remove trailing newline from git_root
			git_root = git_root:gsub("\n$", "")
			-- If we're not already in the git root, cd to it
			if pwd ~= git_root then
				vim.cmd.lcd(git_root)
			end
		else
			-- If not in a git repo, cd to the file's directory
			local file_dir = vim.fn.fnamemodify(buffile, ":p:h")
			if pwd ~= file_dir then
				vim.cmd.lcd(file_dir)
			end
		end
	end,
})
-- change line number based on mode:
-- for command mode: make it absolute for ranges etc
-- for normal mode: relative movements <3
local cmdline_group = vim.api.nvim_create_augroup("CmdlineLinenr", {})
-- debounce cmdline enter events to make sure we dont have flickering for non user cmdline use
-- e.g. mappings using : instead of <cmd>
local cmdline_debounce_timer

vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = cmdline_group,
	callback = function()
		cmdline_debounce_timer = vim.uv.new_timer()
		cmdline_debounce_timer:start(
			100,
			0,
			vim.schedule_wrap(function()
				if vim.o.number then
					vim.o.relativenumber = false
					vim.api.nvim__redraw({ statuscolumn = true })
				end
			end)
		)
	end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = cmdline_group,
	callback = function()
		if cmdline_debounce_timer then
			cmdline_debounce_timer:stop()
			cmdline_debounce_timer = nil
		end
		if vim.o.number then
			vim.o.relativenumber = true
		end
	end,
})

-- Automatically save files when leaving buffer
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
			vim.api.nvim_command("silent! write")
		end
	end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		-- Save cursor position to restore later
		local cursor_pos = vim.api.nvim_win_get_cursor(0)

		-- Remove trailing whitespace
		vim.cmd([[%s/\s\+$//e]])

		-- Restore cursor position
		vim.api.nvim_win_set_cursor(0, cursor_pos)
	end,
})
