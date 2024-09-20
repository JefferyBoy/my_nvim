local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	return
end

local options = {
	ensure_installed = {
		"lua",
		"c",
		"cpp",
		"java",
		"kotlin",
		"make",
		"cmake",
		"html",
		"xml",
		"yaml",
		"css",
		"bash",
		"awk",
		"json",
		"python",
		"rust",
		"diff",
		"asm",
		"bash",
		"http",
		"javascript",
		"markdown",
		"toml",
		"vim",
		"sql",
	},
	auto_install = true,

	highlight = {
		enable = true,
		use_languagetree = true,
	},

	indent = {
		enable = true,
	},
  parse_config = {
    "android_log",
    install_info = {
    }
  }
}

treesitter.setup(options)
