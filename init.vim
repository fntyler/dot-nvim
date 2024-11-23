"-- settings
hi ColorColumn ctermbg=DarkGray guibg=DarkGray

"-- autocmd remove trailing whitespace
"--au FileType c,cpp,java,php,python,javascript,typescript,vim,swig
"--      \ au BufWritePre <buffer> :%s/\s\+$//e

"-- plugin manager
call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

"-- nvim-cmp recommendations
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
"-- nvim-cmp for vsnip users
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

"-- lsp-zero
" copied from lsp-zero example
Plug 'L3MON4D3/LuaSnip'
Plug 'VonHeikemen/lsp-zero.nvim', { 'branch': 'v3.x' }

"-- obsidian.nvim 
Plug 'epwalsh/obsidian.nvim'

"-- gitsigns.nvim
Plug 'lewis6991/gitsigns.nvim'

"-- vim-fugitive
Plug 'tpope/vim-fugitive'

"-- vim-surround
Plug 'tpope/vim-surround'

"-- twilight.nvim
Plug 'folke/twilight.nvim'
"-- zen-mode.nvim
Plug 'folke/zen-mode.nvim'

"-- colorscheme
Plug 'folke/tokyonight.nvim'

"-- markdown-preview
"-- Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"-- peek.nvim
"Plug 'toppair/peek.nvim', { 'do': 'deno task --quiet build:fast' }

"-- todo: why is this here?
"Plug 'nvim-lua/popup.nvim'

call plug#end()

"-- lua-heredoc
lua << EOF
    require('options')
    require('keymaps')
    require('colors')
    require('plugins.lsp')
    require('plugins.treesitter')
    require('plugins.telescope')
    --require('plugins.lspconfig')
    require('plugins.cmp')
    require('plugins.cmp-nvim-lsp')
    require('plugins.obsidian')
    require('plugins.gitsigns')
    require('plugins.surround')
    require('plugins.twilight')
    require('plugins.zen-mode')
EOF
