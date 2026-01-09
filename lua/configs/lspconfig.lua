local present, lspconfig = pcall(require, "lspconfig")

if not present then
	return
end
local util = lspconfig.util

local M = {}

M.on_attach = function(client, bufnr)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

-- 各种语言服务的配置：
-- vim.lsp.config有默认的配置，不需要修改配置的时候可以不写
-- vim.lsp.enable是否自动启用，打开文件时会根据文件类型自动启用
vim.lsp.config('lua_ls', {
	on_attach = M.on_attach,
	capabilities = M.capabilities,

	settings = {
		Lua = {
			runtime = {
				-- lua的版本
				version = "Lua 5.4",
				path = "/usr/share/nvim/runtime/lua",
			},
			diagnostics = {
				-- 识别vim为全局变量
				globals = { "vim" },
			},
			-- 运行环境
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('pylsp')
vim.lsp.enable('jedi_language_server')
vim.lsp.enable('marksman')
vim.lsp.enable('lemminx')
vim.lsp.enable('groovyls')
vim.lsp.config('groovyls', {
	cmd = { "groovy-language-server" },
})
vim.lsp.enable('gradle_ls')
vim.lsp.enable('kotlin_language_server')
vim.lsp.enable('dockerls')
vim.lsp.enable('docker_compose_language_service')
vim.lsp.config('docker_compose_language_service', {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_dir = util.root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
	single_file_support = true,
})
vim.lsp.enable('bashls')
vim.lsp.config('cmake', {
	on_attach = M.on_attach,
	capabilities = M.capabilities,
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	init_options = {
		buildDirectory = "build",
	},
	root_dir = util.root_pattern("CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake"),
	single_file_support = true,
})
vim.lsp.enable('cmake')
vim.lsp.enable('awk_ls')
vim.lsp.enable('asm_ls')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('yamlls')
vim.lsp.enable('ts_ls')
vim.lsp.enable('taplo')
vim.lsp.enable('dartls')
vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
	cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" },
})
vim.lsp.enable('rust_analyzer')
-- vue3
-- vim.lsp.config('volar', {
--   filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
-- }
vim.lsp.enable('vuels')

local jsonls_capabilities = vim.lsp.protocol.make_client_capabilities()
jsonls_capabilities.textDocument.completion.completionItem.snippetSupport = true
vim.lsp.config('jsonls', {
	capabilities = jsonls_capabilities,
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = { provideFormatter = false },
	root_dir = util.find_git_ancestor,
	single_file_support = true,
})
vim.lsp.enable('jsonls')
vim.lsp.enable('buf_ls')
vim.lsp.enable('mesonls')
-- vim.lsp.enable('vim_language_server')
vim.lsp.enable('sql_language_server')


-- jdtls
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

vim.lsp.enable('jdtls')
vim.lsp.config('jdtls', config)
