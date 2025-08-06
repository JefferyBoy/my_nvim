local user_home = os.getenv("HOME")
local cwd_str = string.gsub(vim.fn.getcwd(), "/", "_")

local jdtls_workspace_dir = user_home .. "/.cache/jdtls/workspace/" .. cwd_str
local nvim_config_dir = vim.fn.stdpath("config")

local config = {
	cmd = {
		"jdtls",
		"-Xms1g",
		"-Xmx4g",
		-- 禁用gradle、maven、tycho项目检测
		"-Dtycho.enabled=false",
		"-Dgradle.enabled=false",
		"-Dmaven.enabled=false",
		"--configuration",
		jdtls_workspace_dir .. "/config",
		"-data",
		jdtls_workspace_dir,
	},
	-- root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", "mvnw" }, { upward = true })[1]),
	-- root_dir = path:new(vim.fn.getcwd() .. '/gradlew'):exists() and vim.fn.getcwd() or "",
	root_dir = vim.fn.getcwd(),
	init_options = {
		bundles = {
			-- java调试adapter https://github.com/microsoft/java-debug
			vim.fn.glob(nvim_config_dir .. "/data/com.microsoft.java.debug.plugin-*.jar", true),
		},
	},
	settings = {
		java = {
			-- 不自动导入 Maven/Gradle 项目
      -- 用 Eclipse 格式
			import = {
				maven = { enabled = false },
				gradle = { enabled = false },
				eclipse = { enabled = true },
			},
			configuration = {
				-- 设置编译输出目录
				outputPath = "bin_jdtls",
				-- 禁用构建配置更新
				updateBuildConfiguration = "disabled",
			},
			autobuild = {
				-- 禁用自动构建
				enabled = false,
			},
			indexer = {
				-- 设置索引线程数
				numberOfProcessors = 16,
			},
		},
	},
}
require("jdtls").start_or_attach(config)
