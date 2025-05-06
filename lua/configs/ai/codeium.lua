return {
	"Exafunction/codeium.vim",
	config = function()
		vim.keymap.set("i", "<C-down>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-right>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-left>", function()
			return vim.fn["codeium#CycleCompletions"](-1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })
	end,
}
