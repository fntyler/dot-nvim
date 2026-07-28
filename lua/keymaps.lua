-- netrw Explore
-- vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

-- oil file explorer
vim.keymap.set('n', '<leader>ex', require("oil").open)

-- exit terminal-mode
-- https://neovim.io/doc/user/terminal.html#terminal-input
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- execute the current cursor line in Lua
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { desc = "lua the current line" })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = "lua the current file" })
-- ctrl+shift+c as copy-to-clipboard
-- noremap <C-C> "+y
vim.keymap.set('v', '<C-C>', '\"+y', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- move visual selection up/down
vim.keymap.set('v', 'J', ':m \'>+1<cr>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<cr>gv=gv')

-- wip: size splits
--vim.keymap.set('n', '<M-,>', '<C-w>5<')
--vim.keymap.set('n', '<M-.>', '<C-w>5>')
--vim.keymap.set('n', '<M-m>', '<C-w>+')
--vim.keymap.set('n', '<M-/>', '<C-w>-')

-- source config
-- nnoremap <leader><leader>sv :source $MYVIMRC<cr>
vim.keymap.set('n', '<leader><leader>sv', ':source $MYVIMRC', { noremap = true })
vim.keymap.set('n', '<leader><leader>sh', ':source %<CR>', { noremap = true })

-- close the window showing thelocation list for the current window
-- nnoremap <leader>c :lclose<cr>
vim.keymap.set('n', '<leader>d', ':bdel<cr>', { noremap = true })

-- next/previous buffer
-- nnoremap <leader>b :bn<cr>
vim.keymap.set('n', '<leader>b', ':bn<cr>', { noremap = false })

-- nnoremap <leader>p :bp<cr>
vim.keymap.set('n', '<leader>p', ':bp<cr>', { noremap = false })

-- repeat external command
-- nnoremap <F12> :!!<CR>
vim.keymap.set('n', '<F12>', ':!!<cr>', { noremap = true })

-- search for a line starting with !
-- nnoremap <F2> q:?^!<CR>
vim.keymap.set('n', '<F2>', 'q:?^!<cr>', { noremap = true })

-- remove trailing white space
vim.keymap.set('n', '<leader>ws', [[:%s/\s\+$//e<cr>]], { noremap = true })

-- lsp global defaults (redundant)
vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
vim.keymap.set('n', 'gri', vim.lsp.buf.implementation,
  { desc = 'lists all the implementations for the symbol under the cursor in the quickfix window' })
vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { desc = 'renames all references to the symbol under the cursor' })
vim.keymap.set('n', 'grr', vim.lsp.buf.references,
  { desc = 'lists all the references to the symbol under the cursor in the quickfix window.' })
vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition,
  { desc = ' Jumps to the definition of the type of the symbol under the cursor' })
vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol,
  { desc = 'lists all the implementations for the symbol under the cursor in the quickfix window' })
vim.keymap.set('n', 'grd', vim.lsp.buf.definition, { desc = 'jumps to the definition of the symbol under the cursor' })

-- gh-cli workflow runs for the workflow file in the current buffer
local function gh_workflow_runs(opts)
  opts = opts or {}
  local path = vim.api.nvim_buf_get_name(0)
  if not path:match("%.github/workflows/.+%.ya?ml$") then
    vim.notify("Not a workflow file", vim.log.levels.WARN)
    return
  end
  local file = vim.fn.fnamemodify(path, ":t")
  if opts.web then
    vim.fn.jobstart({ "gh", "workflow", "view", file, "--web" }, { detach = true })
  else
    vim.cmd("botright new")
    vim.fn.termopen({ "gh", "run", "list", "--workflow=" .. file, "--limit=30" })
  end
end

vim.keymap.set('n', '<leader>gw', function() gh_workflow_runs({ web = true }) end,
  { desc = 'gh-cli: open current workflow in browser' })
vim.keymap.set('n', '<leader>gW', function() gh_workflow_runs() end,
  { desc = 'gh-cli: list runs for current workflow' })

-- write a buffer's live contents to a temp .md file so mcat detects markdown
-- and we don't depend on the buffer being saved. returns the path or nil.
local function mcat_write_tmp(src_buf)
  local lines = vim.api.nvim_buf_get_lines(src_buf, 0, -1, false)
  local tmp = vim.fn.tempname() .. '.md'
  if vim.fn.writefile(lines, tmp) ~= 0 then
    return nil
  end
  return tmp
end

-- bind both windows' scroll and realign them. set the option explicitly per
-- window (nvim_set_option_value with win=) and run :syncbind from a known
-- window, since vim.wo/syncbind's "current window" is ambiguous in callbacks.
local function mcat_sync(src_win, render_win)
  vim.api.nvim_set_option_value('scrollbind', true, { win = src_win })
  vim.api.nvim_set_option_value('scrollbind', true, { win = render_win })
  vim.api.nvim_win_call(src_win, function() vim.cmd('syncbind') end)
end

-- (re)render src_buf into render_win as an mcat terminal, replacing whatever
-- buffer currently lives there.
local function mcat_run(src_buf, render_win)
  local tmp = mcat_write_tmp(src_buf)
  if not tmp then
    vim.notify('failed to write temp file for mcat', vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_win_call(render_win, function()
    local old_buf = vim.api.nvim_win_get_buf(render_win)
    vim.cmd('enew')
    -- -c forces ANSI on, -P disables paging (we're in our own scroll buffer)
    vim.fn.termopen({ 'mcat', '-c', '-P', tmp }, {
      on_exit = function() vim.fn.delete(tmp) end,
    })
    -- drop the previous render's terminal buffer so they don't pile up
    if vim.api.nvim_buf_is_valid(old_buf) and old_buf ~= vim.api.nvim_win_get_buf(render_win) then
      vim.api.nvim_buf_delete(old_buf, { force = true })
    end
  end)
end

-- render the current markdown buffer with `mcat` in a terminal split
local function mcat_render()
  if vim.fn.executable('mcat') == 0 then
    vim.notify('mcat not found on PATH', vim.log.levels.ERROR)
    return
  end

  local src_buf = vim.api.nvim_get_current_buf()
  local src_win = vim.api.nvim_get_current_win()

  -- belowright => new vertical split opens to the right of the current window
  vim.cmd('belowright vsplit')
  vim.cmd('enew')
  local render_win = vim.api.nvim_get_current_win()

  mcat_run(src_buf, render_win)
  mcat_sync(src_win, render_win)

  -- keep the cursor in the source window, not the freshly opened render pane
  vim.api.nvim_set_current_win(src_win)

  -- re-render on every write of the source buffer (edit + :w), not on edits
  -- alone. scoped to src_buf; torn down when the render window closes.
  local group = vim.api.nvim_create_augroup('McatRender' .. src_buf, { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = group,
    buffer = src_buf,
    callback = function()
      if not vim.api.nvim_win_is_valid(render_win) or not vim.api.nvim_win_is_valid(src_win) then
        vim.api.nvim_del_augroup_by_id(group)
        return
      end
      mcat_run(src_buf, render_win)
      mcat_sync(src_win, render_win)
    end,
  })
  -- close the render window + wipe its terminal buffer, then stop watching.
  -- deferred with vim.schedule: closing a window inside BufDelete/BufWipeout
  -- mutates the layout mid-command and triggers E855, so run it afterwards.
  local function teardown()
    pcall(vim.api.nvim_del_augroup_by_id, group)
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(render_win) then
        local buf = vim.api.nvim_win_get_buf(render_win)
        pcall(vim.api.nvim_win_close, render_win, true)
        if vim.api.nvim_buf_is_valid(buf) then
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
      end
    end)
  end

  -- source window closed => tear down. render window closed => just stop watching.
  vim.api.nvim_create_autocmd('WinClosed', {
    group = group,
    callback = function(args)
      local win = tonumber(args.match)
      if win == src_win then
        teardown()
      elseif win == render_win then
        pcall(vim.api.nvim_del_augroup_by_id, group)
      end
    end,
  })

  -- source buffer deleted/wiped => tear down the render terminal.
  vim.api.nvim_create_autocmd({ 'BufDelete', 'BufWipeout' }, {
    group = group,
    buffer = src_buf,
    callback = teardown,
  })
end

vim.keymap.set('n', '<leader>mc', mcat_render, { desc = 'render current markdown buffer with mcat' })

-- (wip) custom keymap for yanking
-- yank "<file> <n>: <line text>"
vim.keymap.set('x', '<leader>ly', function()
  local s = vim.fn.line('v')
  local e = vim.fn.line('.')
  if s > e then s, e = e, s end

  local file = vim.fn.expand('%')
  local out = {}
  for i = s, e do
    out[#out + 1] = file .. ':' .. i .. ': ' .. vim.fn.getline(i)
  end

  vim.fn.setreg('+', table.concat(out, '\n'))
  vim.notify(('Copied %d line(s) to clipboard'):format(e - s + 1))
end, { desc = 'Copy file:line: text to clipboard' })
