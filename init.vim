"-- globals
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor=
set relativenumber
set number
set nohlsearch
set hidden
set incsearch
set scrolloff=8
set updatetime=100
"-- Bash like tab-completion
set wildmode=longest:full
set wildoptions=fuzzy
set wildmenu

set colorcolumn=
hi ColorColumn ctermbg=DarkGray guibg=DarkGray

" obsidian.nvim https://github.com/epwalsh/obsidian.nvim/issues/286
set conceallevel=1

"-- configure leader
let mapleader = ' '

"-- ctrl+shift+c as copy-to-clipboard
noremap <C-C> "+y

"-- source config
nnoremap <leader><leader>sv :source $MYVIMRC<cr>

"-- close the window showing thelocation list for the current window
nnoremap <leader>c :lclose<cr>

"-- next/previous buffer
nnoremap <leader>b :bn<cr>
nnoremap <leader>p :bp<cr>

"-- repeat external command
nnoremap <F12> :!!<CR>

"-- search for a line starting with !
nnoremap <F2> q:?^!<CR>

"-- plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"-- nvim-cmp recommendations
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
"-- nvim-cmp for vsnip users
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" obsidian.nvim 
Plug 'epwalsh/obsidian.nvim'

" peek.nvim
" Plug 'toppair/peek.nvim', { 'do': 'deno task --quiet build:fast' }

" gitsigns.nvim
Plug 'lewis6991/gitsigns.nvim'

" vim-fugitive
Plug 'tpope/vim-fugitive'

"Plug 'nvim-lua/popup.nvim'

call plug#end()

"-- lua-heredoc
lua << EOF
    require('plugins.lspconfig')
    require('plugins.treesitter')
    require('plugins.gitsigns')
    require('plugins.cmp')
    require('plugins.cmp-nvim-lsp')
    require('plugins.obsidian')
EOF

"-- nvim.obsidian Keybinding
nnoremap <leader>os :ObsidianQuickSwitch<CR>
nnoremap <leader>ot :ObsidianTags<CR>
nnoremap <leader>od :ObsidianDailies<CR>
nnoremap <leader>oc :ObsidianToggleCheckbox<CR>
nnoremap <leader>ol :ObsidianBacklinks<CR>
vnoremap <leader>ok :ObsidianLink<CR>
nnoremap <leader>op :ObsidianTemplate<CR>

nnoremap <leader>nn /#todo<CR>vel

"-- vim-fugitive Keybinding

"-- Find files using Telescope command-line
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"--Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

"-- nvim-telescope Git Pickers
nnoremap <leader>gh <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>gj <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>gs <cmd>lua require('telescope.builtin').git_stash()<cr>

"-- nvim-telescope Vim Pickers
nnoremap <leader>km <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>aa <cmd>lua require('telescope.builtin').spell_suggest()<cr>


"-- vim-surround
nmap <leader>ss ysiw`
