local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	return
end

local options = {
	ensure_installed = {
		"asm",
		"c",
		"cpp",
		"make",
		"cmake",

		"lua",
		"java",
		"kotlin",
		"python",
		"rust",
		"dart",
		"groovy",
		"javascript",
		"typescript",
		"smali",

		"html",
		"xml",
		"yaml",
		"toml",
		"css",
		"csv",
		"http",
		"vue",

		"bash",
		"awk",
		"json",
		"diff",
		"markdown",
		"vim",
		"sql",
		"ini",
		"nginx",
		"strace",
		"kconfig",
		"git_config",
		"ssh_config",
		"udev",
	},
	auto_install = true,

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = {
		enable = true,
	},
}

treesitter.setup(options)
