local dap = require("dap")
local dapui = require("dapui")

require("nvim-dap-virtual-text").setup({
	enabled = true,
	enable_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,
	only_first_definition = true,
	all_references = false,
	filter_references_pattern = "<module",
	virt_text_pos = "eol",
	all_frames = false,
	virt_lines = false,
	virt_text_win_col = nil,
})

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0 })

local dap_breakpoint = {
	error = {
		text = "🛑",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	condition = {
		text = "󰟃",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	rejected = {
		text = "󰃤",
		texthl = "DapBreakpint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	logpoint = {
		text = "",
		texthl = "DapLogPoint",
		linehl = "DapLogPoint",
		numhl = "DapLogPoint",
	},
	stopped = {
		text = "󰜴",
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	},
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

local mason_root = vim.fn.stdpath("data") .. "/mason"
local mason_bin = mason_root .. "/bin"

-- c, c++, rust
dap.adapters.gdb = {
	type = "executable",
	command = "/usr/bin/gdb",
	args = {
		"--nx", -- 不加载 gdbinit 文件
		"--no-inferior-tty", -- 防止打开额外的终端
	},
}
dap.adapters.codelldb = {
	type = "executable",
	command = mason_bin .. "/codelldb",
	name = "codelldb",
	args = {},
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			local default_path = vim.fn.getcwd()
			return vim.fn.input("Enter executable path: ", default_path, "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false, -- 不停在入口
		args = {}, -- 传入的命令行参数
		options = {
			showDisassembly = "never", -- 不显示汇编代码
		},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- bash
dap.adapters.bashdb = {
	type = "executable",
	command = mason_bin .. "/bash-debug-adapter",
	name = "bashdb",
}
dap.configurations.sh = {
	{
		type = "bashdb",
		request = "launch",
		name = "Launch file",
		showDebugOutput = true,
		pathBashdb = mason_root .. "/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
		pathBashdbLib = mason_root .. "/packages/bash-debug-adapter/extension/bashdb_dir",
		trace = true,
		file = "${file}",
		program = "${file}",
		cwd = "${workspaceFolder}",
		pathCat = "cat",
		pathBash = "/bin/bash",
		pathMkfifo = "mkfifo",
		pathPkill = "pkill",
		args = {},
		env = {},
		terminalKind = "integrated",
	},
}

-- JavaScript/Node.js
dap.adapters.node2 = {
	type = "executable",
	command = mason_bin .. "/node-debug2-adapter",
}
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = mason_bin .. "/js-debug-adapter",
		args = { "${port}" },
	},
}
dap.configurations.javascript = {
	{
		type = "node2",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
}

-- TypeScript
dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		runtimeExecutable = "deno",
		runtimeArgs = {
			"run",
			"--inspect-wait",
			"--allow-all",
		},
		program = "${file}",
		cwd = "${workspaceFolder}",
		attachSimplePort = 9229,
	},
}

-- Python
dap.adapters.python = {
	type = "executable",
	command = "/usr/bin/python3",
	args = { "-m", "debugpy", "--listen", "5678" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch",
		program = "${file}",
		console = "integratedTerminal",
		justMyCode = true,
		pythonPath = "/usr/bin/python3",
	},
}

-- Java
dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		name = "Debug (Attach)",
		hostName = "127.0.0.1",
		port = 5005,
	},
}

-- kotlin
dap.adapters.kotlin = {
	type = "executable",
	command = mason_bin .. "/kotlin-debug-adapter",
	options = { auto_continue_if_many_stopped = false },
}
dap.configurations.kotlin = {
	{
		type = "kotlin",
		request = "launch",
		name = "Launch kotlin",
		-- may differ, when in doubt, whatever your project structure may be,
		-- it has to correspond to the class file located at `build/classes/`
		-- and of course you have to build before you debug
		mainClass = function()
			local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
			local fname = vim.api.nvim_buf_get_name(0)
			-- src/main/kotlin/websearch/Main.kt -> websearch.MainKt
			return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
		end,
		projectRoot = "${workspaceFolder}",
		jsonLogFile = "",
		enableJsonLogging = false,
	},
	{
		-- Use this for unit tests
		-- First, run
		-- ./gradlew --info cleanTest test --debug-jvm
		-- then attach the debugger to it
		type = "kotlin",
		request = "attach",
		name = "Attach debug(kotlin)",
		port = 5005,
		args = {},
		projectRoot = vim.fn.getcwd,
		hostName = "localhost",
		timeout = 2000,
	},
}

-- lua
dap.adapters["local-lua"] = {
	type = "executable",
	command = "local-lua-dbg",
	enrich_config = function(config, on_config)
		if not config.extensionPath then
			local c = vim.deepcopy(config)
			c.extensionPath = "/usr/lib/node_modules/local-lua-debugger-vscode/"
			on_config(c)
		else
			on_config(config)
		end
	end,
}
dap.configurations.lua = {
	{
		name = "Current file (local-lua-dbg, lua)",
		type = "local-lua",
		request = "launch",
		cwd = "${workspaceFolder}",
		program = {
			lua = "lua5.1",
			file = "${file}",
		},
		args = {},
	},
}

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

dapui.setup({
	element_mappings = {
		scopes = {
			edit = "e",
			repl = "r",
		},
		watches = {
			edit = "e",
			repl = "r",
		},
		stacks = {
			open = "g",
		},
		breakpoints = {
			open = "g",
			toggle = "b",
		},
	},

	layouts = {
		{
			elements = {
				"scopes",
				"stacks",
				"breakpoints",
				"watches",
			},
			size = 0.2, -- 40 columns
			position = "left",
		},
		{
			elements = {
				"repl",
			},
			size = 0.25, -- 25% of total lines
			position = "bottom",
		},
		{
			elements = {
				"console",
			},
			size = 0.2,
			position = "right",
		},
	},

	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "rounded", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})
