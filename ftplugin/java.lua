local user_home = os.getenv("HOME")
local cwd_str = string.gsub(vim.fn.getcwd(), "/", "_")

local jdtls_home_dir = user_home .. "/.cache/jdtls/config"
local jdtls_data_dir = user_home .. "/.cache/jdtls/workspace/"..cwd_str

local config = {
	cmd = {
    "jdtls",
    "--configuration", jdtls_home_dir,
    "-data", jdtls_data_dir,
  },
	-- root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "mvnw" }, { upward = true })[1]),
  -- root_dir = path:new(vim.fn.getcwd() .. '/gradlew'):exists() and vim.fn.getcwd() or "",
  root_dir = vim.fn.getcwd(),
	init_options = {
		bundles = {
			vim.fn.glob(
				"/media/mxlei/data/home/mxlei/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
				true
			),
		},
	},
}
require("jdtls").start_or_attach(config)
