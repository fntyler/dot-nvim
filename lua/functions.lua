-- set colorcolumn=80
-- hi ColorColumn ctermbg=DarkGray guibg=DarkGray

function toggle_cc()
    local cc = vim.wo.cc
    local function isempty(v)
        return v == nil or v == ''
    end
    if isempty(vim.wo.cc) then
        vim.wo.cc = 80
    else
        vim.wo.cc = ''
    end
end
