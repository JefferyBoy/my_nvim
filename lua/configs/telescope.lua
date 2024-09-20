local M = {}

-- 根据字符串查询文件
-- todo 未生效
M.find_files_with_input = function(prompt)
	local telescope = require("telescope.builtin")
	telescope.find_files({
		prompt_args = {
			default = prompt,
		},
    prompt_text = prompt
	})
end

M.find_files_in_word = function()
	local z = vim.fn.eval("@z")
	vim.cmd("normal! viw")
	vim.cmd('normal! "zy')
	local text = vim.fn.eval("@z")
	vim.cmd("let @z = '" .. z .. "'")
	M.find_files_with_input(text)
end

M.setup = function()
	local options = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			-- file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = { "node_modules" },
			-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			path_display = { "truncate" },
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			-- Developer configurations: Not meant for general override
			buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
			mappings = {
				n = { ["q"] = require("telescope.actions").close },
			},
		},

		extensions_list = { "themes", "terms", "recent_files", "cmdline" },
	}
	-- 配置telescope
	local telescope = require("telescope")
	telescope.setup(options)

	-- 加载telescope的插件
	pcall(function()
		for _, ext in ipairs(options.extensions_list) do
			telescope.load_extension(ext)
		end
	end)
end

return M
