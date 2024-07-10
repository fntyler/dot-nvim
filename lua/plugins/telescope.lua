-- nvim-telescope

-- -- List Pickers
vim.keymap.set('n', '<leader>B', require('telescope.builtin').builtin, { desc = 'list builtins' })

-- -- Vim Pickers
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'find files' })

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'show recently opened files' })

-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'live grep files' })

-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'search buffers' })

-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'search help tags' })

-- nnoremap <leader>km <cmd>lua require('telescope.builtin').keymaps()<cr>
vim.keymap.set('n', '<leader>km', require('telescope.builtin').keymaps, { desc = 'normal mode keymaps' })

-- nnoremap <leader>aa <cmd>lua require('telescope.builtin').spell_suggest()<cr>
vim.keymap.set('n', '<leader>aa', require('telescope.builtin').spell_suggest, { desc = 'spell check' })

-- -- Git Pickers
-- nnoremap <leader>gh <cmd>lua require('telescope.builtin').git_status()<cr>
vim.keymap.set('n', '<leader>gh', require('telescope.builtin').git_status, { desc = 'git status' })

-- nnoremap <leader>gj <cmd>lua require('telescope.builtin').git_branches()<cr>
vim.keymap.set('n', '<leader>gj', require('telescope.builtin').git_branches, { desc = 'git branches' })

-- nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_stash()<cr>
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_stash, { desc = 'git stash' })

