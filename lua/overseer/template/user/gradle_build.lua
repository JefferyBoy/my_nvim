local fileutil = require("utils.file")

return {
	name = "gradle run",
	params = {
		task = {
			type = "string",
			name = "task name",
			order = 1,
			optional = false,
			default = "assembleDebug",
		},
	},
	condition = {
		callback = function(opts)
    local found = vim.fs.find("gradlew", { upward = true, type = "file", path = opts.dir })[1]
			if not found then
				return false, "Not gradle project"
			end
			return true
		end,
	},
	builder = function(params)
		return {
			cmd = { "./gradlew" },
			args = { params.task },
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
