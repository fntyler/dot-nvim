-- netrw Explore
-- vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

-- oil file explorer
vim.keymap.set('n', '<leader>ex', require("oil").open)

-- exit terminal-mode
-- https://neovim.io/doc/user/terminal.html#terminal-input
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- execute the current cursor line in Lua
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { desc = "lua the current line" })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = "lua the current file" })
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

-- lsp global defaults (redundant)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation,
  { desc = 'lists all the implementations for the symbol under the cursor in the quickfix window' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'renames all references to the symbol under the cursor' })
vim.keymap.set('n', 'grr', vim.lsp.buf.references,
  { desc = 'lists all the references to the symbol under the cursor in the quickfix window.' })
vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition,
  { desc = ' Jumps to the definition of the type of the symbol under the cursor' })
vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol,
  { desc = 'lists all the implementations for the symbol under the cursor in the quickfix window' })
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'jumps to the definition of the symbol under the cursor' })
