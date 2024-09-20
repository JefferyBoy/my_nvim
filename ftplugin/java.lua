local path = require 'plenary.path'
local config = {
	cmd = { "jdtls" },
	-- root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "mvnw" }, { upward = true })[1]),
  -- root_dir = path:new(vim.fn.getcwd() .. '/gradlew'):exists() and vim.fn.getcwd() or "",
  root_dir = vim.fn.getcwd(),
	init_options = {
		bundles = {
			vim.fn.glob(
				"/media/mxlei/data/home/mxlei/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
				1
			),
		},
	},
}
require("jdtls").start_or_attach(config)
