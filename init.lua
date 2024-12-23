vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
--require("plugins.telescope")

require("colors")
require("keymaps")
require("options")

require("plugins.lsp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.obsidian")
require("plugins.gitsigns")
