"-- globals
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor=
set relativenumber
set nu
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
    -- Setup language servers
    local lspconfig = require('lspconfig')
    lspconfig.pyright.setup {}

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    -- treesitter
    require('plugins.treesitter')

    require('plugins.gitsigns')

    -- Set up nvim-cmp - start
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
      }, {
        { name = 'buffer' },
      })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    --require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    --  capabilities = capabilities
    --}
    -- Set up nvim-cmp - end

    -- nvim.obsidian
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
