require("base.options")
require('base.lazy')
require('base.mappings')

-- 设置文件类型检测
vim.cmd([[  
  au BufRead,BufNewFile *.log set filetype=android_log  
]])
