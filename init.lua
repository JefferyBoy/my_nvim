require("base.environment")
require("base.options")
require("base.lazy")
require("base.mappings")

-- 设置文件类型检测
-- vim.cmd([[
--   au BufRead,BufNewFile *.log set filetype=android_log
-- ]])

-- 设置寄存器，避免使用st终端时使用ctrl+r读取寄存器时卡死
-- 原因：wl-parse命令卡死，需要向剪贴板写入内容后才正常
-- if os.getenv("WAYLAND_DISPLAY") then
-- 	vim.fn.setreg("0", "nvim")
-- 	vim.fn.setreg("+", "nvim")
-- end
