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

  -- Use `:Obsidian quick_switch` style commands (legacy `:ObsidianQuickSwitch` style is removed in 4.0).
  legacy_commands = false,

  -- The 'mappings' option was removed in the community fork; buffer-local
  -- mappings are now set when entering a note.
  -- See: https://obsidian-nvim.github.io/obsidian.nvim/Keymaps
  callbacks = {
    enter_note = function(_)
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault,
      -- falling back to the builtin 'gf' when the cursor isn't on a link.
      vim.keymap.set("n", "gf", function()
        if require("obsidian.api").cursor_link() then
          require("obsidian.actions").follow_link()
        else
          vim.cmd("normal! gf")
        end
      end, { buffer = true, desc = "Obsidian follow link (gf passthrough)" })

      -- Toggle check-boxes with labels
      vim.keymap.set("n", "<leader>ch", function()
        local line = vim.api.nvim_get_current_line()
        local new_line

        if line:match("%- %[ %] TODO") then
          local dt = os.date("%Y%m%d-%H%M")
          new_line = line:gsub("%- %[ %] TODO", "- [x] DONE " .. dt)
        elseif line:match("%- %[x%] DONE") then
          new_line = line:gsub("%- %[x%] DONE %d%d%d%d%d%d%d%d%-%d%d%d%d", "- [>] PROG")
          if new_line == line then
            new_line = line:gsub("%- %[x%] DONE", "- [>] PROG")
          end
        elseif line:match("%- %[>%] PROG") then
          new_line = line:gsub("%- %[>%] PROG", "- [~] ABAN")
        elseif line:match("%- %[~%] ABAN") then
          new_line = line:gsub("%- %[~%] ABAN", "- [ ] TODO")
        else
          -- No checkbox found, insert one at the start of the line (preserving indent)
          local indent, rest = line:match("^(%s*)(.*)")
          new_line = indent .. "- [ ] TODO " .. rest
        end

        vim.api.nvim_set_current_line(new_line)
      end, { buffer = true, desc = "Cycle TODO/DONE/PROG/ABAN checkbox" })
    end,
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
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M",
    substitutions = {
      yesterday = function()
        return os.date("%Y-%m-%d", os.time() - 86400)
      end
    },
  },

  -- 'follow_url_func' was removed in the community fork; URLs are opened with
  -- vim.ui.open by default (uses `open` on macOS). Override via `open.func` if needed.

  ui = {
    enable = true,         -- set to false to disable all additional syntax features
    update_debounce = 200, -- update delay after a text change (in milliseconds)
    -- 'ui.checkboxes' is left commented out: these glyphs/highlights are identical to the
    -- community fork's defaults, and setting the key triggers a deprecation warning on startup.
    -- -- Define how various check-boxes are displayed
    -- checkboxes = {
    --   -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
    --   [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
    --   ["x"] = { char = "", hl_group = "ObsidianDone" },
    --   [">"] = { char = "", hl_group = "ObsidianRightArrow" },
    --   ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },

    --   -- You can also add more custom ones...
    --   -- NOTE: cycle order for `:Obsidian toggle_checkbox` is set by `checkbox.order` below.
    -- },
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

  picker = {
    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
    name = "telescope.nvim",
    -- Optional, configure key mappings for the picker. These are the defaults.
    -- Not all pickers support all mappings.
    note_mappings = {
      -- Create a new note from your query.
      new = "<C-x>",
      -- Insert a link to the selected note.
      insert_link = "<C-l>",
    },
    tag_mappings = {
      -- Add tag(s) to current note.
      tag_note = "<C-x>",
      -- Insert a tag at the current location.
      insert_tag = "<C-l>",
    },
  },

  -- Cycle order for `:Obsidian toggle_checkbox`: " " -> x first, then the rest of
  -- the fork defaults (default order is { " ", "~", "!", ">", "x" }).
  checkbox = {
    order = { " ", "x", "~", "!", ">" },
  },

  search = {
    sort_by = "modified",
    sort_reversed = true,
  },

  -- Optional, determines how certain commands open notes. The valid options are:
  -- 1. "current" (the default) - to always open in the current window
  -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
  -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
  open_notes_in = "current",

  -- Specify how to handle attachments.
  attachments = {
    -- The default folder to place images in via `:Obsidian paste_img`.
    -- If this is a relative path it will be interpreted as relative to the vault root.
    -- You can always override this per image by passing a full path to the command instead of just a filename.
    folder = "assets/imgs",
    -- A function that determines the text to insert in the note when pasting an image.
    -- In the community fork it only receives the path (no `client` argument).
    ---@param path obsidian.Path|string the absolute path to the image file
    ---@return string
    img_text_func = function(path)
      local p = require("obsidian.path").new(path)
      local rel = p:vault_relative_path() or tostring(p)
      return string.format("![%s](%s)", p.name, rel)
    end,
  },

})

-- keymaps
-- nnoremap <leader>os :ObsidianQuickSwitch<CR>
vim.keymap.set('n', '<leader>os', ':Obsidian quick_switch<CR>',
  { noremap = false, desc = 'ObsidianQuickSwitch quickly switch to (or open) another note in vault' })
-- nnoremap <leader>ot :ObsidianTags<CR>
vim.keymap.set('n', '<leader>ot', ':Obsidian tags<CR>',
  { noremap = false, desc = 'ObsidianTags picker list of all occurrences of the given tags' })
-- nnoremap <leader>od :ObsidianDailies<CR>
vim.keymap.set('n', '<leader>od', ':Obsidian dailies<CR>',
  { noremap = false, desc = 'ObsidianDailies picker list of daily notes' })
-- nnoremap <leader>oc :ObsidianToggleCheckbox<CR>
vim.keymap.set('n', '<leader>oc', ':Obsidian toggle_checkbox<CR>',
  { noremap = false, desc = 'ObsidianBacklinks picker list of references to the current buffer' })
-- nnoremap <leader>ol :ObsidianBacklinks<CR>
vim.keymap.set('n', '<leader>ol', ':Obsidian backlinks<CR>',
  { noremap = false, desc = 'ObsidianBacklinks picker list of references to the current buffer' })
-- vnoremap <leader>ok :ObsidianLink<CR>
vim.keymap.set('v', '<leader>ok', '<cmd>Obsidian link<CR>',
  {
    noremap = false,
    desc =
    'ObsidianLink link an inline visual selection of text to a note. This command has one optional argument: a query that will be used to resolve the note by ID, path, or alias. If not given, the selected text will be used as the query.'
  })
-- nnoremap <leader>op :ObsidianTemplate<CR>
vim.keymap.set('n', '<leader>op', ':Obsidian template<CR>',
  { noremap = false, desc = 'ObsidianTemplate insert a template from the templates folder' })
-- nnoremap <leader>op :ObsidianTemplate<CR>
vim.keymap.set('n', '<leader>oh', ':Obsidian toc<CR>',
  { noremap = false, desc = 'ObsidianTOC load the table of contents of the current note into a picker list' })
-- vnoremap <leader>ox :ObsidianTemplate<CR>
vim.keymap.set('v', '<leader>ox', ':Obsidian extract_note<CR>',
  { noremap = false, desc = 'ObsidianExtractNote to extract the visually selected text into a new note and link to it' })
vim.keymap.set('n', '<leader>oT', ':Obsidian new_from_template<CR>',
  {
    noremap = false,
    desc =
    'ObsidianNewFromTemplate to create a new note from a template in the templates folder: [TITLE]'
  })
vim.keymap.set('n', '<leader>ou', ':Obsidian links<CR>',
  { noremap = false, desc = 'ObsidianLinks to collect all links within the current buffer into a picker window' })
