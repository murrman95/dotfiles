local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

local plugins = {
  'christoomey/vim-tmux-navigator',
  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-lua/plenary.nvim',
  {'catppuccin/nvim', as = 'catppuccin' },
  {'neoclide/coc.nvim', branch = 'release'},
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
}

local opts = {}

require("lazy").setup(plugins, opts)

require("core.keymaps")
require("core.plugin_config")
