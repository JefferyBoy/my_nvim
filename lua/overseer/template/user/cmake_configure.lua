return {
	name = "cmake configure",
	params = {
		build_type = {
			type = "enum",
			name = "Build type",
			order = 1,
			optional = false,
			default = "debug",
			choices = { "debug", "release", "coverage" },
		},
		-- build_dir = {
		--   name = "Build Directory",
		--   order = 2,
		--   optional = true,
		--   default = "build",
		-- },
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
		-- todo 根据当前buffer的路径，查找最近路径上的CMakeLists.txt
		return {
			cmd = { "cmake" },
			args = {
				".",
				"-B=build",
				-- "-B=" .. tostring(params.build_dir),
				-- '-G=Unix Makefiles',
				"-DCMAKE_BUILD_TYPE=" .. params.build_type,
				"-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
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
