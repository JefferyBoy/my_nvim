local dap = require("dap")
local mason_root = vim.fn.stdpath("data") .. "/mason"
local mason_bin = mason_root .. "/bin"

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
