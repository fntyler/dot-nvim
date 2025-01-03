-- let mapleader = ' '
--vim.g.mapleader = ' '
--vim.g.maplocalleader = "\\"

-- set tabstop=4 softtabstop=4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- set shiftwidth=4
vim.opt.shiftwidth = 4

-- set expandtab
vim.opt.expandtab = true

-- set smartindent
vim.opt.smartindent = true

-- set relativenumber
vim.opt.relativenumber = true

-- stop adding comments with 'o'
vim.opt.formatoptions:remove "o"

-- set guicursor=
vim.g.guicursor = ''

-- set relativenumber
vim.o.relativenumber = true

-- set nu / set number
vim.o.number = true

-- set nohlsearch
vim.opt.hlsearch = false

-- set hidden
vim.g.hidden = true

-- set incsearch
vim.g.incsearch = true

-- set inccommand
vim.opt.inccommand = 'split'

-- set scrolloff=8
vim.opt_global.scrolloff = 8

-- set updatetime=100
vim.g.updatetime = 100

-- set wildmode=longest:full
vim.g.wildmenu = 'longest:full'

-- set wildoptions=fuzzy
vim.g.wildoptions = 'fuzzy'

-- set wildmenu
vim.g.wildmenu = true

-- set colorcolumn=
vim.wo.colorcolumn = ''

--hi ColorColumn ctermbg=DarkGray guibg=DarkGray

-- obsidian.nvim https://github.com/epwalsh/obsidian.nvim/issues/286
-- set conceallevel=1
vim.wo.conceallevel = 1
