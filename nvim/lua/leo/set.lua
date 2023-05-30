vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.splitbelow = true
vim.opt.splitright = true

-- CoqtailChecked xxx ctermbg=17 guibg=LightGreen

-- vim.cmd[[autocmd ColorScheme * hi def CoqtailSent ctermbg=021]] -- Blue (https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg)
-- vim.cmd[[hi Folded ctermbg=233]]
-- vim.cmd([[
-- augroup CoqtailHighlights
--   autocmd!
--   autocmd ColorScheme *
--     \  hi def CoqtailSent    ctermbg=021 
-- augroup END
-- ]]) -- Blue (https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg)

    -- \| hi def CoqtailChecked ctermbg=199 " Pink
