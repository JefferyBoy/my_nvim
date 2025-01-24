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

lspconfig.lua_ls.setup({
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
lspconfig.clangd.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})
lspconfig.pylsp.setup({})
lspconfig.jedi_language_server.setup({})
lspconfig.marksman.setup({})
lspconfig.lemminx.setup({})
lspconfig.groovyls.setup({})
lspconfig.gradle_ls.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})
-- lspconfig.jdtls.setup({
--   root_dir = vim.fn.getcwd,
-- })
lspconfig.kotlin_language_server.setup({
	on_attach = M.on_attach,
	capabilities = M.capabilities,
})
lspconfig.dockerls.setup({})
lspconfig.docker_compose_language_service.setup({
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose" },
	root_dir = util.root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
	single_file_support = true,
})
lspconfig.bashls.setup({})
lspconfig.cmake.setup({
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
lspconfig.awk_ls.setup({})
lspconfig.asm_lsp.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.yamlls.setup({})
lspconfig.ts_ls.setup({})
lspconfig.taplo.setup({})
lspconfig.dartls.setup({})
lspconfig.rust_analyzer.setup({
  cmd = { vim.fn.stdpath("data") .. '/mason/bin/rust-analyzer' }
})
-- vue3
-- require'lspconfig'.volar.setup{
--   filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
-- }
require'lspconfig'.vuels.setup{}


local jsonls_capabilities = vim.lsp.protocol.make_client_capabilities()
jsonls_capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.jsonls.setup({
	capabilities = jsonls_capabilities,
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = { provideFormatter = false },
	root_dir = util.find_git_ancestor,
	single_file_support = true,
})
-- lspconfig.vim_language_server.setup { }
-- lspconfig.sql_language_server.setup { }
lspconfig.buf_ls.setup { }
lspconfig.mesonlsp.setup { }
