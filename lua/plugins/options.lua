local utils = require('core.utils')
local custom = require('config.custom')
local package_enabled = utils.package_enabled
local inc = utils.include_script
local has_py3 = (vim.fn.has('python3') ~= 0)

return {
	{
		'itchyny/vim-cursorword',
		enabled = package_enabled('cursorword'),
		config = function()
			vim.g.cursorword_delay = 100
			vim.g.cursorword = 0
		end,
	},

	{
		'justinmk/vim-dirvish', 
		enabled = not package_enabled('oil'),
		config = function() 
			inc('site/bundle/dirvish.vim') 
		end 
	},
	
	{
		'stevearc/oil.nvim',
		enabled = package_enabled('oil'),
		config = function()
			require('oil').setup()
		end
	},

	{
		'andymass/vim-matchup',
		enabled = package_enabled('matchup'),
		config = function()
			-- disable matchit
			vim.g.loaded_matchit = 1
			inc('site/bundle/matchup.vim')
		end
	},

	{
		"NeogitOrg/neogit",
		enabled = package_enabled('neogit'),
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua",              -- optional
		},
		config = true
	},

	{
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		enabled = package_enabled('lazygit'),
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},

}


