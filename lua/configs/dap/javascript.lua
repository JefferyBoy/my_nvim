local dap = require("dap")
local mason_root = vim.fn.stdpath("data") .. "/mason"
local mason_bin = mason_root .. "/bin"

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

