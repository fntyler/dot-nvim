-- ctrl+shift+c as copy-to-clipboard
-- noremap <C-C> "+y
vim.keymap.set('n', '<C-C>', '\"+y', { noremap = true })

vim.keymap.set({'n', 'v'}, '<leader>y', [["+y]])

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('v', 'J', ':m \'>+1<cr>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<cr>gv=gv')

-- source config
-- nnoremap <leader><leader>sv :source $MYVIMRC<cr>
vim.keymap.set('n', '<leader><leader>sv', ':source $MYVIMRC', { noremap = true })

-- close the window showing thelocation list for the current window
-- nnoremap <leader>c :lclose<cr>
vim.keymap.set('n', '<leader>c', ':lclose<cr>', { noremap = true })

-- next/previous buffer
-- nnoremap <leader>b :bn<cr>
vim.keymap.set('n', '<leaser>b', ':bn<cr>', { noremap = true })

-- nnoremap <leader>p :bp<cr>
vim.keymap.set('n', '<leader>p', ':bp<cr>', { noremap = true })

-- repeat external command
-- nnoremap <F12> :!!<CR>
vim.keymap.set('n', '<F12>', ':!!<cr>', { noremap = true })

-- search for a line starting with !
-- nnoremap <F2> q:?^!<CR>
vim.keymap.set('n', '<F2>', 'q:?^!<cr>', { noremap = true })
