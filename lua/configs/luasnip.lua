local present, luasnip = pcall(require, "luasnip")

if not present then
	return
end

local options = {
	history = true,
	updateevents = "TextChanged,TextChangedI",
}
luasnip.config.set_config(options)

require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load {
  paths = vim.g.luasnippets_path or ""
}
require("luasnip.loaders.from_vscode").lazy_load({
		paths = "~/.config/nvim/snippets",
})
require("luasnip.loaders.from_vscode").lazy_load()

-- friendly-snippets - enable standardized comments snippets
require("luasnip").filetype_extend("lua", { "luadoc" })
require("luasnip").filetype_extend("python", { "pydoc" })
require("luasnip").filetype_extend("rust", { "rustdoc" })
require("luasnip").filetype_extend("java", { "javadoc" })
require("luasnip").filetype_extend("c", { "cdoc" })
require("luasnip").filetype_extend("cpp", { "cppdoc" })
require("luasnip").filetype_extend("kotlin", { "kdoc" })
require("luasnip").filetype_extend("sh", { "shelldoc" })
require("luasnip").filetype_extend("make", { "makedoc" })
