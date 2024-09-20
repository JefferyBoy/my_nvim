return {
	name = "cmake run",
	params = {
		target = {
			type = "string",
			name = "Target",
			order = 1,
			optional = false,
			default = "app",
		},
		args = {
			type = "list",
			delimiter = " ",
			name = "Arguments",
			order = 2,
			optional = true,
		},
	},
	condition = {
		callback = function(opts)
			if vim.fn.executable("cmake") == 0 then
				return false, 'Command "cmake" not found'
			end
      local found = vim.fs.find("CMakeLists.txt", { upward = true, type = "file", path = opts.dir })[1]
			if not found then
				return false, "No CMakeLists.txt found"
			end
			return true
		end,
	},
	builder = function(params)
		return {
			cmd = { "./build/" .. params.target },
			args = params.args,
			components = {
				{
					"on_output_quickfix",
					set_diagnostics = true,
          open = true,
				},
				"on_result_diagnostics",
				"default",
			},
		}
	end,
}
