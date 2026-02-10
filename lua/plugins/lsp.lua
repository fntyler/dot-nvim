local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- neovim 0.11+ with nvim-lspconfig
-- bashls
vim.lsp.enable('bashls')

-- pyright
vim.lsp.enable('pyright')

-- gh-actions-language-server
vim.lsp.enable('gh_actions_ls')

-- lua_ls
vim.lsp.enable('lua_ls')
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local c = vim.lsp.get_client_by_id(args.data.client_id)
    if not c then return end

    if vim.bo.filetype == "lua" then
      -- Format the current buffer on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
        end,
      })
    end

    --  TODO: flow like, save trigger → format file on disk → reload buffer to see changes → complete the save operation.
    -- if vim.bo.filetype == "python" then
    --   -- Format Python files with Black on save
    --   vim.api.nvim_create_autocmd('BufWritePre', {
    --     buffer = args.buf,
    --     callback = function()
    --       vim.fn.system('uv run python black --quiet ' .. vim.fn.shellescape(vim.fn.expand('%:p')))
    --       vim.cmd('edit!')
    --     end,
    --   })
    -- end
  end,
})
