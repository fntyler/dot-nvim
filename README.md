# dot-neovim

neovim configuration

neovim configuration file: `~/.config/nvim/init.vim`

neovim dir setup: `mkdir -vp lua pack plugged`

lua code in vimscript: [lua-guide](https://neovim.io/doc/user/lua-guide.html)

## plugin manager - vim-plug

installation:

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

`:PlugInstall`, install plugin (reload configuration file before).

`:PlugUpdate`, update plugins. 

* After the update is finished, review the changes by pressing `D` in the window. Or, you can do it later by running `:PlugDiff`.

`:PlugClean`, delete dangling plugins.


### plugin - nvim-lspconfig

installation:

install language server:

```sh
$ npm -i -g pyright
$ require'lspconfig'.pyright.setup{}
```

`:LspInfo`, display status or to troubleshoot.


### plugin - nvim-telescope

`<leader>ff`, find files

`<leader>fg`, live grep

`<leader>fb`, buffers

`<leader>fh`, help tags




### plugin - nvim-treesitter

`:TSInstall <language_to_install>`, install (already supported) lanuage parser.

* `plugged/nvim-treesitter/parser/{language}.so`, parser installation path.

`:TSUpdate <language_to_update>`, update parser.


### plugin - vim-gitgutter

installation:

```sh
mkdir -p ~/.config/nvim/pack/airblade/start
cd ~/.config/nvim/pack/airblade/start
git clone https://github.com/airblade/vim-gitgutter.git
nvim -u NONE -c "helptags vim-gitgutter/doc" -c q
```

`]c`, jump to next hunk. (default)

* remap: `nmap ]h <plug>(GitGutterNextHunk)`

`[c`, jump to previous hunk.

* remap: `nmap [h <plug>(GitGutterPrevHunk)`

`<leader>hp`, preview the hunk.

`<leader>hs`, visually select then stage hunk.

`:43,50GitGutterStageHunk`, using range stage hunk.

`<leader>hu`, undo hunk.


### plugin - epwalsh/obsidian.nvim

installation:

```
Plug 'epwalsh/obsidian.nvim'
```

additionally,

```
" obsidian.nvim https://github.com/epwalsh/obsidian.nvim/issues/286
set conceallevel=1
```

### plugin - vim-surround

```sh
mkdir -p ~/.config/nvim/pack/tpope/start
cd ~/.config/nvim/pack/tpope/start
git clone https://tpope.io/vim/surround.git
nvim -u NONE -c "helptags surround/doc" -c q
```
