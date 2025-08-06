local M = {}
local file_utils = require("utils.file")
local telescope_last_search = ""
local telescope_last_results = ""

M.find_files_in_word = function()
	-- local z = vim.fn.eval("@z")
	-- vim.cmd("normal! viw")
	-- vim.cmd('normal! "zy')
	-- local text = vim.fn.eval("@z")
	-- vim.cmd("let @z = '" .. z .. "'")
	local text = vim.fn.expand("<cword>")
	require("telescope.builtin").find_files({
		search_file = text,
	})
end

M.find_string_in_word = function()
	require("telescope.builtin").grep_string({})
end

M.show_last_results = function()
    if telescope_last_results then
        require("telescope.builtin").find_files({
            search_file = telescope_last_search,
            results = telescope_last_results
        })
    else
        print("没有上次的搜索结果")
    end
end

-- 内容过滤忽略的目录
local get_livegrep_ignore_patterns = function()
  local isAospDir = file_utils.file_exists(vim.fn.getcwd() .. "/Android.bp")
  local basicIgnorePatterns = {}
  if isAospDir then
    table.insert(basicIgnorePatterns, "!out/")
    table.insert(basicIgnorePatterns, "!test/")
    table.insert(basicIgnorePatterns, "!build/")
    table.insert(basicIgnorePatterns, "!system/")
    table.insert(basicIgnorePatterns, "!toolchain/")
  end
  return basicIgnorePatterns
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
				i = {
					["<CR>"] = function(prompt_bufnr)
            local actions_state = require("telescope.actions.state")
            local picker = actions_state.get_current_picker(prompt_bufnr)
						require("telescope.actions").select_default(prompt_bufnr)
					end,
				},
			},
		},

		extensions_list = { "themes", "terms", "recent_files", "cmdline", "persisted" },
	}

  -- todo 设置忽略目录后，无法搜索到任何内容
  -- local ignore_patterns = get_livegrep_ignore_patterns()
  -- for _,pattern in ipairs(ignore_patterns) do
  --   table.insert(options.defaults.vimgrep_arguments, "--glob='" .. pattern .. "'")
  -- end
  -- print(vim.inspect(options.defaults.vimgrep_arguments))

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
