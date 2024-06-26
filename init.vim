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
set wildmode=longest:full,full
set wildmenu

set colorcolumn=80
hi ColorColumn ctermbg=DarkGray guibg=DarkGray

" obsidian.nvim https://github.com/epwalsh/obsidian.nvim/issues/286
set conceallevel=1

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
    require'nvim-treesitter.configs'.setup {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }

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
    -- Set up nvim.obsidian
    local obsidian = require("obsidian").setup({
        workspaces = {
            {
                name = "whitepages",
                path = "~/dev/whitepages",
            },
        },

        log_level = vim.log.levels.INFO,

        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "dailies",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%Y-%m-%d",
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = nil
          },

        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
              action = function()
                return require("obsidian").util.gf_passthrough()
              end,
              opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
              action = function()
                return require("obsidian").util.toggle_checkbox()
              end,
              opts = { buffer = true },
            },
        },

        -- Optional, customize how names/IDs for new notes are created.
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
              -- If title is given, transform it into valid file name.
              suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
              -- If title is nil, just add 4 random uppercase letters to the suffix.
              for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
              end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,

        templates = {
            -- templates directory
            subdir= "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {},
        },

        -- -- Optional, customize the backlinks interface.
        -- backlinks = {
        --     -- The default height of the backlinks location list.
        --     height = 10,
        --     -- Whether or not to wrap lines.
        --     wrap = true,
        -- },

        -- -- Optional, customize the tags interface.
        -- tags = {
        --     -- The default height of the tags location list.
        --     height = 10,
        --     -- Whether or not to wrap lines.
        --     wrap = true,
        -- },

        ui = {
            enable = true,  -- set to false to disable all additional syntax features
            update_debounce = 200,  -- update delay after a text change (in milliseconds)
            -- Define how various check-boxes are displayed
            checkboxes = {
              -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
              [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
              ["x"] = { char = "", hl_group = "ObsidianDone" },
              [">"] = { char = "", hl_group = "ObsidianRightArrow" },
              ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },

              -- You can also add more custom ones...
            },
            -- Use bullet marks for non-checkbox lists.
            bullets = { char = "•", hl_group = "ObsidianBullet" },
            external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            -- Replace the above with this if you don't have a patched font:
            -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
            reference_text = { hl_group = "ObsidianRefText" },
            highlight_text = { hl_group = "ObsidianHighlightText" },
            tags = { hl_group = "ObsidianTag" },
            block_ids = { hl_group = "ObsidianBlockID" },
            hl_groups = {
              -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
              ObsidianTodo = { bold = true, fg = "#f78c6c" },
              ObsidianDone = { bold = true, fg = "#89ddff" },
              ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
              ObsidianTilde = { bold = true, fg = "#ff5370" },
              ObsidianBullet = { bold = true, fg = "#89ddff" },
              ObsidianRefText = { underline = true, fg = "#c792ea" },
              ObsidianExtLinkIcon = { fg = "#c792ea" },
              ObsidianTag = { italic = true, fg = "#89ddff" },
              ObsidianBlockID = { italic = true, fg = "#89ddff" },
              ObsidianHighlightText = { bg = "#75662e" },
            },
          },

          sort_by = "modified",
          sort_reversed = true,

          -- Optional, determines how certain commands open notes. The valid options are:
          -- 1. "current" (the default) - to always open in the current window
          -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
          -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
          open_notes_in = "current",

          -- Specify how to handle attachments.
          attachments = {
            -- The default folder to place images in via `:ObsidianPasteImg`.
            -- If this is a relative path it will be interpreted as relative to the vault root.
            -- You can always override this per image by passing a full path to the command instead of just a filename.
            img_folder = "assets/imgs",  -- This is the default
            -- A function that determines the text to insert in the note when pasting an image.
            -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
            -- This is the default implementation.
            ---@param client obsidian.Client
            ---@param path obsidian.Path the absolute path to the image file
            ---@return string
            img_text_func = function(client, path)
              path = client:vault_relative_path(path) or path
              return string.format("![%s](%s)", path.name, path)
            end,
          },

    })
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

"-- GitGutter
"- sign list
highlight SignColumn ctermbg=7 
"highlight SignColumn guibg=7 ctermbg=7
highlight GitGutterAdd ctermfg=10
highlight GitGutterChange ctermfg=11
highlight GitGutterDelete ctermfg=9
"highlight! link SignColumn LineNr
let g:gitgutter_sign_removed = 'x'
"let g:gitgutter_set_sign_backgrounds = 0
"let g:gitgutter_preview_win_location

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

