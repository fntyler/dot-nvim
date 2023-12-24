# dot-neovim

neovim config

neovim configuration file: `~/.config/nvim/init.vim`

lua code in vimscript: [lua-guide](https://neovim.io/doc/user/lua-guide.html)

## plugin manager - vim-plug

installation path: `~/.local/share/nvim/site/autoload`

`:PlugInstall`, install plugin (reload configuration file before).

`:PlugUpdate`, update plugins. 

* After the update is finished, review the changes by pressing `D` in the window. Or, you can do it later by running `:PlugDiff`.

`:PlugClean`, delete dangling plugins.

### plugin - nvim-treesitter

`:TSInstall <language_to_install>`, install (already supported) lanuage parser.

* `plugged/nvim-treesitter/parser/{language}.so`, parser installation path.

`:TSUpdate <language_to_update>`, update parser
