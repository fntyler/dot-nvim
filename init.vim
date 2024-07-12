"-- settings
hi ColorColumn ctermbg=DarkGray guibg=DarkGray

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
    require('options')
    require('plugins.telescope')
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

"-- vim-surround
nmap <leader>ss ysiw`
