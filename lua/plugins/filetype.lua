return {
	"nathom/filetype.nvim",
	config = function()
		-- Setup overrides for file extensions
		require("filetype").setup({
			overrides = {
				extensions = {
					tf = "terraform",
					tfvars = "terraform",
					tfstate = "json",
				},
			},
		})
	end,
}
