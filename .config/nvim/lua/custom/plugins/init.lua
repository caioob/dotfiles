-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	-- Colorscheme
	{ 'rose-pine/neovim',       name = 'rose-pine' },
	-- Auto close plugin for brackets
	{ 'm4xshen/autoclose.nvim', name = 'autoclose' },
	{ "aserowy/tmux.nvim",      config = function() return require("tmux").setup() end },
	{ 'nvim-lua/plenary.nvim' },
	{ 'ThePrimeagen/harpoon' },
	{ 'mbbill/undotree',        config = function() vim.g.undotree_SetFocusWhenToggle = 1 end },
}
