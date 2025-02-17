require("core.options") -- Load general options
require("core.keymaps") -- Load general keymaps
require("core.auto-commands") -- Load auto commands
require("core.snippets") -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require("lazy").setup({
	require("plugins.oil"),
	require("plugins.multi"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.cmp"),
	require("plugins.conform"),
	require("plugins.which-key"),
	require("plugins.vim-sleuth"),
	require("plugins.gitsigns"),
	require("plugins.colorscheme"),
	require("plugins.mini"),
	require("plugins.todo-comments"),
	require("plugins.nvim-autopairs"),
	require("plugins.nvim-colorizer"),
	require("plugins.git"),
	require("plugins.treesitter"),
	require("plugins.indent-line"),
	require("plugins.debug"),
	require("plugins.nvim-lint"),
	require("plugins.spectre"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.flash"),
	require("plugins.harpoon"),
	require("plugins.autotag"),
	require("plugins.illuminate"),
	require("plugins.noice"),
	require("plugins.dressing"),
	require("plugins.trouble"),
	require("plugins.copilot"),
	require("plugins.refactoring"),
	require("plugins.satellite"),
	require("plugins.comment"),
	require("plugins.typescript-tools"),
	require("plugins.ufo"),
	require("plugins.endwise"),
	require("plugins.neotest"),
	require("plugins.varnish"),
	require("plugins.diagnostics"),
	require("plugins.schema-store"),
	require("plugins.reactive"),
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
