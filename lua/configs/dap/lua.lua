local dap = require("dap")

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

