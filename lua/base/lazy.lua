-- lazy.nvim包管理
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"folke/which-key.nvim",
	{
		"folke/neoconf.nvim",
		cmd = "Neoconf",
	},
	"folke/neodev.nvim",
	-- telescope显示各种窗口
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jonarrien/telescope-cmdline.nvim",
		},
		config = function(_, opts)
			require("configs/telescope").setup()
		end,
	},
	-- UI组件
	"MunifTanjim/nui.nvim",
	-- 代码高亮
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("configs/treesitter")
		end,
	},
	-- 在编辑器顶部常驻显示当前函数的名称
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup()
		end,
	},
	-- 文件侧边栏
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("configs/nvimtree")
		end,
	},
	-- 快捷注释
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	-- lazygit
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- lsp
	{
		"williamboman/mason.nvim",
		config = function()
			require("configs/mason")
		end,
	},
	"williamboman/mason-lspconfig.nvim",
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs/lspconfig")
		end,
	},
	-- 主题
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("configs/catppuccin")
		end,
	},
	-- 状态栏
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			animation = true,
			insert_at_start = true,
		},
		version = "^1.7.0",
	},
	-- 终端
	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	-- 括号引号等成对符号处理
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- ts中写html标签自动闭合
	{
		"windwp/nvim-ts-autotag",
	},
	-- 代码提示
	{
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
		module = { "cmp", "cmp_nvim_lsp" },
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = "friendly-snippets",
		config = function()
			require("configs/cmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets", "nvim-cmp" },
		build = "make install_jsregexp",
		config = function(_, opts)
			if opts then
				require("luasnip").config.setup(opts)
			end
			require("configs/luasnip")
		end,
	},
	{
		"saadparwaiz1/cmp_luasnip",
		dependencies = "LuaSnip",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		dependencies = "cmp_luasnip",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = "cmp-nvim-lua",
	},
	{
		"hrsh7th/cmp-buffer",
		dependencies = "cmp-nvim-lsp",
	},
	{
		"hrsh7th/cmp-path",
		dependencies = "cmp-buffer",
	},
	-- 生成函数注释
	{
		"danymat/neogen",
		config = function()
			require("neogen").setup({
				enabled = true,
				input_after_comment = true,
				snippet_engine = "luasnip",
			})
		end,
	},
	-- 变量重命名
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},
	-- 代码格式化
	{
		"mhartington/formatter.nvim",
		config = function()
			require("configs.formatter")
		end,
	},
	-- 缩进显示、对齐
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			require("configs.indent_blankline")
		end,
	},
	-- 快速修改成对符号（如引号、括号等）
	{
		"kylechui/nvim-surround",
		version = "main",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	-- 底部状态栏
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark",
				},
			})
		end,
	},
	-- 调试
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-telescope/telescope-dap.nvim",
			"mfussenegger/nvim-dap-python",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			require("nvim-dap-virtual-text").setup()
			require("dapui").setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	-- todo显示、查找
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		config = function()
			require("todo-comments").setup()
		end,
	},
	-- 消息提示
	{
		"rcarriga/nvim-notify",
	},
	-- 颜色串显示
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({})
		end,
	},
	-- 翻译
	{
		"voldikss/vim-translator",
		config = function()
			vim.g.translator_target_lang = "zh"
			vim.g.translator_source_lang = "auto"
			vim.g.translator_proxy_url = ""
			-- 'bing', 'google', 'haici', 'iciba'(expired), 'sdcv', 'trans', 'youdao'
			vim.g.translator_default_engines = { "bing", "haici" }
		end,
	},
	-- 代码大纲outline
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				-- keymaps = {
				-- 	["<CR>"] = false,
				-- },
			})
		end,
	},
	-- 任务管理
	{
		"stevearc/overseer.nvim",
		config = function()
			require("overseer").setup({
				templates = require("overseer.template.user.tasks"),
			})
		end,
	},
	-- nvim-jdtls
	"mfussenegger/nvim-jdtls",
	-- 光标跳转
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			require("flash").setup({
				modes = {
					char = {
						enabled = false,
					},
				},
			})
		end,
		opts = {},
	},
	-- markdown图片显示
	-- {
	-- 	"3rd/image.nvim",
	-- },
	--
	-- markdown预览
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- 启动页
	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("dashboard").setup({
	-- 			theme = "hyper",
	-- 		})
	-- 	end,
	-- 	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- },
	-- 启动页
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	-- 历史项目切换
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				manual_mode = true,
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "Makefile", "package.json", "CMakeLists.txt", "Android.bp" },
				ignore_lsp = {},
				exclude_dirs = {},
				show_hidden = false,
				silent_chdir = true,
				scope_chdir = "global",
				datapath = vim.fn.stdpath("data"),
			})
			require("telescope").load_extension("projects")
		end,
	},
	-- 侧边滚动条scrollbar
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup({
				show = true,
				show_in_active_only = false,
				set_hightlights = true,
				folds = 1000,
				max_lines = false,
				hide_if_all_visible = false,
				throttle_ms = 100,
				handle = {
					text = " ",
					blend = 30,
					color = "#636e72",
					color_nr = nil,
					highlight = "CursorColumn",
					hide_if_all_visible = true,
				},
			})
		end,
	},
	-- 书签管理
	{
		"JefferyBoy/bookmark_nvim",
		dir = "/home/mxlei/data/code/vim-bookmark_nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("bookmark_nvim").setup({
				sidebar = {
					fix_keymap_conflict = true,
					keymaps = {
						bookmark_move_up = "K",
						bookmark_move_down = "J",
					},
				},
			})
		end,
	},
	-- 变量重命名
	"JefferyBoy/renamer.nvim",
	-- terminal模式切换buffer后保持上次的模式
	"JefferyBoy/stay_mode.nvim",
	-- git diff工具
  "JefferyBoy/git_diff.nvim",
	-- 自动切换输入法
	"JefferyBoy/fcitx.nvim",
	-- 关键词快速搜索
	"JefferyBoy/keyword_search.nvim",
	-- adb dumpsys分析
	"JefferyBoy/adb_dumpsys.nvim",
	-- 内建终端
	{
		"JefferyBoy/nvterm",
		dependencies = "akinsho/toggleterm.nvim",
		config = function()
			require("configs.nvterm")
		end,
	},
}

-- AI代码生成
local ai_code_suggession = {
	fittencode = {
		"luozhiya/fittencode.nvim",
		opts = {},
	},
	colipot = {
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "github/copilot.vim" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {},
	},
	codeium = {
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
	},
	bropilot = {
		"meeehdi-dev/bropilot.nvim",
		event = "VeryLazy", -- preload model on start
		dependencies = {
			"nvim-lua/plenary.nvim",
			"j-hui/fidget.nvim",
		},
		config = function()
			local opts = {
				auto_suggest = true,
				excluded_filetypes = {},
				-- 模型：starcoder2:3b qwen2.5-coder:1.5b-base deepseek-coder-v2:16b codegeex4:latest
				model = "deepseek-coder-v2:latest",
				preset = true,
				debounce = 500,
				-- prompt = { -- FIM prompt for starcoder2
				-- 	prefix = "<fim_prefix>",
				-- 	suffix = "<fim_suffix>",
				-- 	middle = "<fim_middle>",
				-- },
				keymap = {
					-- accept_line = "<TAB>",
					-- accept_word = "<C-Right>",
					accept_block = "c-down",
					suggest = "<c-Enter>",
				},
				ollama_url = "http://172.16.159.27:11434/api",
			}
			require("bropilot").setup(opts)
		end,
	},
	-- 仅支持neovim 0.10.1及以上
	avante = {
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		opts = {
			--- "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
			provider = "claude",
			auto_suggestions_provider = "claude",
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-5-sonnet-20241022",
				temperature = 0,
				max_tokens = 4096,
			},
			openai = {
				endpoint = "https://api.deepseek.com",
				model = "deepseek-coder",
				timeout = 30000,
				temperature = 0,
				max_tokens = 4096,
        api_key = "sk-5e536bf4db71460aac8a9d39dd27f639",
			},
			-- openai = {
			-- 	endpoint = "https://api.openai.com/v1",
			-- 	model = "gpt-4o",
			-- 	timeout = 30000,
			-- 	temperature = 0,
			-- 	max_tokens = 4096,
			-- },
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "gpt-4o-2024-08-06",
				proxy = nil, -- [protocol://]host[:port] Use this proxy
				allow_insecure = false,
				timeout = 30000,
				temperature = 0,
				max_tokens = 4096,
			},
		},
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua",
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	codecompanion = {
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
		},
		config = function()
			require("codecompanion").setup({
				send_code = true,
				strategies = {
					chat = {
						adapter = "ollama",
					},
					inline = {
						adapter = "ollama",
					},
				},
				adapters = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							name = "deepseek-coder-v2",
							schema = {
								model = {
									default = "deepseek-coder-v2:16b",
								},
								num_ctx = {
									default = 16384,
								},
								num_predict = {
									default = -1,
								},
							},
							env = {
								url = "http://172.16.159.27:11434",
								chat_url = "/v1/chat/completions",
								api_key = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ0ZWU1MzJjLTM2YTktNDZmYS05N2E3LWExZDRmMzA1MDc4NCJ9.R1B6B2GPAwBEmAugdMill1tiIzaRYtvyMnr_5fSrKfs",
							},
							headers = {
								["Content-Type"] = "application/json",
								["Authorization"] = "Bearer ${api_key}",
							},
							parameters = {
								sync = true,
							},
						})
					end,
					anthropic = function()
						return require("codecompanion.adapters").extend("anthropic", {
							env = {
								api_key = "MY_OTHER_ANTHROPIC_KEY",
							},
						})
					end,
				},
			})
		end,
	},
}
table.insert(plugins, ai_code_suggession.codeium)
require("lazy").setup(plugins)
