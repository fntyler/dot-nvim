return {

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },

  -- lsp configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },

      -- source for neovim builtint language server client
      { "hrsh7th/cmp-nvim-lsp" },

    },
  },

  -- neovim completion in Lua
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  -- 'hrsh7th/cmp-cmdline'
  --
  -- nvim-cmp for vsnip users
  -- 'hrsh7th/cmp-vsnip'
  -- 'hrsh7th/vim-vsnip'

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = "0.1.8",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
      -- other dependency: https://github.com/sharkdp/fd
    },
  },

  -- obsidian
  {
    "epwalsh/obsidian.nvim",
    version = "v3.9.0", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
      -- refer to `:h file-pattern` for more examples
      --"BufReadPre path/to/my-vault/*.md",
      --"BufNewFile path/to/my-vault/*.md",
      "BufReadPre " .. vim.fn.expand "~" .. "dev/work/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "dev/work/*.md",
    },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
  },

  -- git wrapper
  {
    "tpope/vim-fugitive"
  },

  -- github extension for fugitive.vim
  {
    "tpope/vim-rhubarb"
  },

  -- git decorator
  {
    "lewis6991/gitsigns.nvim"
  },

  -- helper
  {
    "tpope/vim-surround"
  },

  -- gh helper
  {
    "pwntester/octo.nvim",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require "octo".setup()
    end
  },

  {
    "folke/sidekick.nvim",
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = "tmux",
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").focus() end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
        desc = "Sidekick Toggle Claude",
      },
    },
  }

}
