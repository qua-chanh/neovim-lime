local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.cmdheight = 0
opt.cursorline = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.foldenable = false
-- opt.foldexpr = "treesitter#fold()"
opt.foldmethod = "expr"
-- opt.indentexpr = "treesitter#indent()"
opt.laststatus = 3
opt.list = true
opt.listchars = [[tab:\ ,trail:-,eol:↵]]
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 18
opt.shortmess = "atOIc"
opt.showmatch = true
opt.showmode = false
opt.showtabline = 2
opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.updatetime = 300