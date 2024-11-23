-- colorscheme

if not vim.opt.termguicolors:get() then
    vim.opt.termguicolors = true
end


if vim.opt.background == 'dark' then
    vim.opt.background = 'dark'
    vim.cmd.colorscheme("tokyonight-night")
else
    vim.opt.background = 'light'
    vim.cmd.colorscheme("tokyonight-day")
end
