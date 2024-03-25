require('nvim-tmux-navigation').setup({
      disable_when_zoomed = true -- defaults to false
})

vim.keymap.set('n', "<C-h>", "NvimTmuxNavigateLeft<CR>")
vim.keymap.set('n', "<C-j>", "NvimTmuxNavigateDown<CR>")
vim.keymap.set('n', "<C-k>", "NvimTmuxNavigateUp<CR>")
vim.keymap.set('n', "<C-l>", "NvimTmuxNavigateRight<CR>")
vim.keymap.set('n', "<C-\\>", "NvimTmuxNavigateLastActive<CR>")
vim.keymap.set('n', "<C-Space>", "NvimTmuxNavigateNext<CR>")

