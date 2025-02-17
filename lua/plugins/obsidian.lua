---- helper (wip)
--function pathExists(path)
--    local file = io.open(path, "r")
--    if file then
--        file:close()
--        return true
--    else
--        return false
--    end
--end
--
--local test_path = "~/dev/work"
--local ws_name
--local ws_path
--
--if pathExists(test_path) then
--    print("yes")
--    ws_name = "work"
--    ws_path = "~/dev/work"
--else
--    print("yes")
--    ws_name = "whitepages"
--    ws_path = "~/dev/whitepages"
--end

-- nvim.obsidian
require("obsidian").setup({
  workspaces = {
    {
      name = "work",
      path = "~/dev/work",
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
    }
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
    subdir = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    substitutions = {},
  },

  ui = {
    enable = true,         -- set to false to disable all additional syntax features
    update_debounce = 200, -- update delay after a text change (in milliseconds)
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
    img_folder = "assets/imgs", -- This is the default
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

-- keymaps
-- nnoremap <leader>os :ObsidianQuickSwitch<CR>
vim.keymap.set('n', '<leader>os', ':ObsidianQuickSwitch<cr>', { noremap = false })
-- nnoremap <leader>ot :ObsidianTags<CR>
vim.keymap.set('n', '<leader>ot', ':ObsidianTags<CR>', { noremap = false })
-- nnoremap <leader>od :ObsidianDailies<CR>
vim.keymap.set('n', '<leader>od', ':ObsidianDailies<CR>', { noremap = false })
-- nnoremap <leader>oc :ObsidianToggleCheckbox<CR>
vim.keymap.set('n', '<leader>oc', ':ObsidianToggleCheckbox<CR>', { noremap = false })
-- nnoremap <leader>ol :ObsidianBacklinks<CR>
vim.keymap.set('n', '<leader>ol', ':ObsidianBacklinks<CR>', { noremap = false })
-- vnoremap <leader>ok :ObsidianLink<CR>
vim.keymap.set('v', '<leader>ok', ':ObsidianLink<CR>', { noremap = false })
-- nnoremap <leader>op :ObsidianTemplate<CR>
vim.keymap.set('n', '<leader>op', ':ObsidianTemplate<CR>', { noremap = false })
-- nnoremap <leader>op :ObsidianTemplate<CR>
vim.keymap.set('n', '<leader>oo', ':ObsidianTOC<CR>', { noremap = false })
-- nnoremap <leader>nn /#todo<CR>vel
vim.keymap.set('n', '<leader>nn', '/#todo<CR>vel', { noremap = false })
