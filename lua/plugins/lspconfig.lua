-- neovim/nvim-lspconfig
local lsp = require('lspconfig')
--require('lspconfig').pyright.setup({})
--require('lspconfig').ansiblels.setup({})


vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
