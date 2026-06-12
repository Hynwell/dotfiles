local opt = vim.opt

-- Line numbers (off — позиция видна в статусбаре lualine)
opt.number         = false
opt.relativenumber = false

-- Indentation
opt.tabstop        = 2
opt.shiftwidth     = 2
opt.expandtab      = true
opt.smartindent    = true

-- UI
opt.termguicolors  = true
opt.signcolumn     = "yes"
opt.cursorline     = true
opt.scrolloff      = 8
opt.sidescrolloff  = 8
opt.wrap           = false

-- Search
opt.ignorecase     = true
opt.smartcase      = true
opt.hlsearch       = true
opt.incsearch      = true

-- Files
opt.undofile       = true
opt.swapfile       = false
opt.backup         = false

-- Clipboard (system)
opt.clipboard      = "unnamedplus"

-- Splits
opt.splitright     = true
opt.splitbelow     = true

-- Misc
opt.mouse          = "a"
opt.updatetime     = 250
opt.timeoutlen     = 500
opt.completeopt    = "menu,menuone,noselect"
opt.fileencoding   = "utf-8"

-- Neovim >= 0.9
if vim.fn.has("nvim-0.9") == 1 then
    opt.splitkeep = "screen"
end
