local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- neovim 0.11+ with nvim-lspconfig
-- bashls
vim.lsp.enable 'bashls'

-- pyright
vim.lsp.enable('pyright')

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
  end,
})
