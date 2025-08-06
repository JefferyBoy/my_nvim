local dap = require("dap")

-- Python
dap.adapters.python = {
	type = "executable",
	command = "/usr/bin/python3",
	args = { "-m", "debugpy.adapter"},
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch",
		program = "${file}",
		console = "integratedTerminal",
		-- 可选参数：只调试用户代码，不步入标准库
		justMyCode = true,
		-- 如果你用的是虚拟环境，确保下面路径对应到正确的 Python 解释器
		pythonPath = function()
			local cwd = vim.fn.getcwd()
			if vim.fn.filereadable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.filereadable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				-- 或者你的默认路径
				return "/usr/bin/python3"
			end
		end,
	},
}

