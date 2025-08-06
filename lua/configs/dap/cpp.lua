local dap = require("dap")
local mason_root = vim.fn.stdpath("data") .. "/mason"
local mason_bin = mason_root .. "/bin"

-- c, c++, rust
dap.adapters.gdb = {
	type = "executable",
	command = "/usr/bin/gdb",
	args = {
		"--nx", -- 不加载 gdbinit 文件
	},
}
dap.adapters.codelldb = {
	type = "executable",
	command = mason_bin .. "/codelldb",
	name = "codelldb",
	args = {},
}
dap.adapters.codelldb_server = {
	type = "server",
	host = "127.0.0.1",
	port = "${port}",
	executable = {
		command = mason_bin .. "/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "codelldb", -- 配置名称，也是显示的任务名称
		type = "codelldb", -- adapter的名称
		request = "launch",
		program = function()
			local default_path = vim.fn.getcwd()
			return vim.fn.input("Enter executable path: ", default_path, "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false, -- 停在入口
		args = {}, -- 传入的命令行参数
		options = {
			showDisassembly = "never", -- 不显示汇编代码
		},
	},
	{
		name = "Attach Android Native",
		type = "codelldb_server",
		request = "attach",
		pid = function()
			-- 通过 ADB 获取目标进程 ID
			local handle = io.popen("adb shell ps -A | grep com.example.app.jni | awk '{print $2}'")
			local pid = handle:read("*a"):gsub("%s+", "")
			handle:close()
			return pid
		end,
		program = function()
			-- 指定动态库路径（如 libnative-lib.so）
			return vim.fn.input(
				"Path to .so: ",
				vim.fn.getcwd() .. "/app-jni/build/intermediates/cxx/debug/6y32i3t1/obj/arm64-v8a/",
				"file"
			)
		end,
		cwd = "${workspaceFolder}",
		sourceMap = {
			["/jni"] = "${workspaceFolder}/app-jni/src/main/cpp/src",
		},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
