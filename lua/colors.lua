-- colorscheme
if not vim.opt.termguicolors:get() then
    vim.opt.termguicolors = true
end

vim.opt.background = 'dark'

if vim.opt.background:get() == 'dark' then
    vim.cmd.colorscheme("tokyonight-night")
else
    vim.cmd.colorscheme("tokyonight-day")
end
