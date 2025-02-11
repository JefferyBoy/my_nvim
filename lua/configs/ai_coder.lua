-- AI代码生成
local M = {}
M.fittencode = {
	"luozhiya/fittencode.nvim",
	opts = {},
}
M.codeium = {
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
M.avante = {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		provider = "bailian",
		auto_suggestions_provider = "bailian",
		vendors = {
			bailian = {
				__inherited_from = "openai",
				api_key_name = "ALIBAILIAN_API_KEY",
				endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
				-- model = "deepseek-r1",
				model = "deepseek-r1-distill-qwen-32b",
			},
			deepseek = {
				__inherited_from = "openai",
				api_key_name = "DEEPSEEK_API_KEY",
				endpoint = "https://api.deepseek.com",
				model = "deepseek-coder",
			},
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
}
M.codecompanion = {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	},
	config = function()
		require("codecompanion").setup({
			ops = {
				log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
				send_code = true,
				language = "Chinese",
			},
			strategies = {
				chat = {
					adapter = "siliconflow",
				},
				inline = {
					adapter = "siliconflow",
				},
			},
			adapters = {
				deepseek = function()
					return require("codecompanion.adapters").extend("deepseek", {
						env = {
							api_key = "DEEPSEEK_API_KEY",
						},
					})
				end,
				siliconflow = function()
					return require("codecompanion.adapters").extend("openai", {
						name = "siliconflow",
						formatted_name = "siliconflow",
						env = {
							api_key = "SILICONFLOW_API_KEY",
						},
						url = "https://api.siliconflow.cn/v1/chat/completions",
						schema = {
							model = {
								default = "Pro/deepseek-ai/DeepSeek-R1",
								choices = {
									"deepseek-ai/DeepSeek-V3",
									"deepseek-ai/DeepSeek-R1",
									"Pro/deepseek-ai/DeepSeek-R1",
									"Pro/deepseek-ai/DeepSeek-V3",
									"deepseek-ai/DeepSeek-R1-Distill-Llama-70B",
									"deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
									"Qwen/Qwen2.5-Coder-32B-Instruct",
									"Qwen/Qwen2-VL-72B-Instruct",
								},
							},
						},
					})
				end,
				alibailian = function()
					return require("codecompanion.adapters").extend("openai", {
						name = "alibailian",
						formatted_name = "alibailian",
						env = {
							api_key = "ALIBAILIAN_API_KEY",
						},
						url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
						schema = {
							model = {
								default = "deepseek-r1-distill-llama-70b",
								choices = {
									"deepseek-r1",
									"deepseek-v3",
									"deepseek-r1-distill-qwen-7b",
									"deepseek-r1-distill-llama-8b",
									"deepseek-r1-distill-qwen-14b",
									"deepseek-r1-distill-qwen-32b",
									"deepseek-r1-distill-llama-70b",
									"qwen-plus",
								},
							},
						},
					})
				end,
			},
			prompt_library = {
				-- 添加翻译文本的功能
				translate = {
					strategy = "chat",
					description = "Translate to chinese",
					opts = {
						index = 6,
						is_default = true,
						is_slash_cmd = false,
						modes = { "v" },
						short_name = "translate",
						auto_submit = true,
						user_prompt = false,
						stop_context_insertion = true,
					},
					prompts = {
						{
							role = "user",
							content = function(context)
								local code = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)

								return string.format(
									[[Please translate this code to chinese:

```%s
%s
```
]],
									context.filetype,
									code
								)
							end,
							opts = {
								contains_code = true,
							},
						},
					},
				},
			},
		})
	end,
}
return M
