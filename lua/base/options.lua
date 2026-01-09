local opt = vim.opt
local g = vim.g

-- 超级键
g.mapleader = " "

opt.laststatus = 3
opt.showmode = false
-- 系统剪贴板
opt.clipboard = "unnamedplus"
-- 光标高亮
opt.cursorline = true
opt.cursorcolumn = false
opt.termguicolors = true
opt.synmaxcol = 500   -- 只高亮前 500 列
opt.synmaxcol = 3000  -- 正常文件的高亮列数

-- 缩进
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.fillchars = { eob = " " }

-- 搜索忽略大小写
opt.ignorecase = true
opt.smartcase = true

-- 光标行显示
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = true

-- Neovim default updatetime is 4000
vim.opt.updatetime = 500

-- 编码 utf-8,ucs-bom,gb18030,gbk,cp936,latin1
opt.fileencodings = "utf-8"
