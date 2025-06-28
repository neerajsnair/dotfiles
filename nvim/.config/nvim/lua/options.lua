vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set termguicolors")
vim.opt.clipboard:append("unnamedplus")
vim.o.showmode = false

-- Enable persistent undo
local undodir = vim.fn.expand("~/.cache/nvim/undo")
vim.fn.mkdir(undodir, "p")
vim.opt.undofile = true
vim.opt.undodir = undodir

-- Theme
vim.cmd.colorscheme "tokyonight" 
