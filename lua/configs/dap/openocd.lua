local os = require("os")
local dap = require("dap")

local function get_build_elf_path()
  -- 查找cwd/build 目录下的 elf 文件
  local cwd = vim.fn.getcwd()
  local build_dir = cwd.. "/build"

  local handle = vim.loop.fs_scandir(build_dir)
  if not handle then 
    return ""
  end
  while true do
    local name, typ = vim.loop.fs_scandir_next(handle)
    if not name then break end
    local full_path = build_dir .. '/' .. name
    if typ ~= 'directory' and full_path:match('%.elf$') then
      return full_path
    end
  end
  vim.loop.fs_closedir(handle)
  return ""
end

-- ARM芯片调试器配置（使用 OpenOCD）
-- 命令执行：
--     openocd -f interface/stlink.cfg -f target/stm32f4x.cfg
--     arm-none-eabi-gdb main.elf

table.insert(dap.configurations.c, {
	type = "gdb",
	request = "launch",
	name = "OpenOCD Debug",
	executable = "${workspaceFolder}/build/main.elf", -- 替换为你实际的 ELF 文件路径
	program = "${workspaceFolder}/build/main.elf",
	debuggerPath = "/usr/bin/arm-none-eabi-gdb",
	gdbpath = "/usr/bin/arm-none-eabi-gdb",
	debugServerPath = "/usr/bin/openocd",
	debugServerArgs = "-f interface/stlink-v2.cfg -f target/stm32f1x.cfg",
	stopAtEntry = true,
	openOCDLaunchArgs = {
		"-f",
		"interface/stlink.cfg",
		"-f",
		"target/stm32f4x.cfg",
	},
	internalConsoleOptions = "openOnSessionStart",
})
