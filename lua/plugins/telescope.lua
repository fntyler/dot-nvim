-- -- nvim-telescope
require("telescope").setup {
  extensions = {
    fzf = {}
  }
}

-- List Pickers
vim.keymap.set('n', '<leader>B', require('telescope.builtin').builtin, { desc = 'list builtins' })

-- Vim Pickers
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'find files' })

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'show recently opened files' })

vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'live grep files' })

vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'search buffers' })

vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'search help tags' })

vim.keymap.set('n', '<leader>km', require('telescope.builtin').keymaps, { desc = 'normal mode keymaps' })

-- nnoremap <leader>aa <cmd>lua require('telescope.builtin').spell_suggest()<cr>

-- Git Pickers
vim.keymap.set('n', '<leader>gh', require('telescope.builtin').git_status, { desc = 'git status' })

vim.keymap.set('n', '<leader>gj', require('telescope.builtin').git_branches, { desc = 'git branches' })

vim.keymap.set('n', '<leader>gs', require('telescope.builtin').git_stash, { desc = 'git stash' })
