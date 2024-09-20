return {
  name = "cmake rm build",
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
  builder = function()
    return {
      cmd = { "rm" },
      args = { "-rf", "build" },
    }
  end,
}
