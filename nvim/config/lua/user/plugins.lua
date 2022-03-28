local fn = vim.fn

-- Bootstrap packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- bootstrap plugins
return packer.startup(function()
	use("wbthomason/packer.nvim") -- Package manager
	use("lewis6991/impatient.nvim")

	-- ui/ux
	use("Mofiqul/dracula.nvim")
	use("akinsho/bufferline.nvim")
	use("akinsho/toggleterm.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("nvim-lualine/lualine.nvim")

	-- cmp
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp") -- cmp lsp completions
	use("hrsh7th/cmp-nvim-lua")
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")

	-- lsp
	use("onsails/lspkind-nvim")
	use("neovim/nvim-lspconfig")
	use("nvim-lua/lsp-status.nvim")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- git
	use("TimUntersberger/neogit")
	use("lewis6991/gitsigns.nvim")
	use("ThePrimeagen/git-worktree.nvim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
