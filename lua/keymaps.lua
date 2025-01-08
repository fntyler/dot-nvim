-- netrw Explore
vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

-- execute the current cursor line in Lua
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { desc = "lua the current line" })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = "lua the current line" })
-- ctrl+shift+c as copy-to-clipboard
-- noremap <C-C> "+y
vim.keymap.set('v', '<C-C>', '\"+y', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('v', 'J', ':m \'>+1<cr>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<cr>gv=gv')

-- wip: size splits
--vim.keymap.set('n', '<M-,>', '<C-w>5<')
--vim.keymap.set('n', '<M-.>', '<C-w>5>')
--vim.keymap.set('n', '<M-m>', '<C-w>+')
--vim.keymap.set('n', '<M-/>', '<C-w>-')

-- source config
-- nnoremap <leader><leader>sv :source $MYVIMRC<cr>
vim.keymap.set('n', '<leader><leader>sv', ':source $MYVIMRC', { noremap = true })
vim.keymap.set('n', '<leader><leader>sh', ':source %<CR>', { noremap = true })

-- close the window showing thelocation list for the current window
-- nnoremap <leader>c :lclose<cr>
vim.keymap.set('n', '<leader>d', ':bdel<cr>', { noremap = true })

-- next/previous buffer
-- nnoremap <leader>b :bn<cr>
vim.keymap.set('n', '<leader>b', ':bn<cr>', { noremap = false })

-- nnoremap <leader>p :bp<cr>
vim.keymap.set('n', '<leader>p', ':bp<cr>', { noremap = false })

-- repeat external command
-- nnoremap <F12> :!!<CR>
vim.keymap.set('n', '<F12>', ':!!<cr>', { noremap = true })

-- search for a line starting with !
-- nnoremap <F2> q:?^!<CR>
vim.keymap.set('n', '<F2>', 'q:?^!<cr>', { noremap = true })

-- remove trailing white space
vim.keymap.set('n', '<leader>ws', [[:%s/\s\+$//e<cr>]], { noremap = true })

-- nvim-lspconfig keymaps
vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'grr', vim.lsp.buf.references)
