return {
	name = "cmake build",
	params = {
		target = {
			type = "string",
			name = "Target",
			order = 1,
			optional = false,
			default = "all",
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
			cmd = { "cmake" },
			args = {
				"--build",
				"build",
				"--target",
				params.target,
			},
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
