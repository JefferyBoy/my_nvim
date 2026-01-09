local aliyun_bailian_models = {
	"qwen-plus",
	"qwen-max",
	"qwen-turbo",
	"qwen-long",
	"qwen-coder-plus",
	"qwen3-max",
	"qwen3-coder-plus",
	"qwen-72b-chat",
	"qwen-14b-chat",
	"deepseek-r1",
	"deepseek-v3",
	"deepseek-v3.1",
	"deepseek-v3.2-exp",
	"deepseek-r1-distill-qwen-7b",
	"deepseek-r1-distill-llama-8b",
	"deepseek-r1-distill-qwen-14b",
	"deepseek-r1-distill-qwen-32b",
	"deepseek-r1-distill-llama-70b",
	"qwen2.5-coder-32b-instruct",
	"qwen2.5-coder-14b-instruct",
	"llama3.3-70b-instruct",
	"llama3.1-405b-instruct",
	"baichuan2-turbo",
	"baichuan2-13b-chat-v1",
	"chatglm3-6b",
	"chatglm3-6b-v2",
	"abab6.5g-chat",
	"abab6.5t-chat",
	"abab6.5s-chat",
	"ziya-llama-13b-v1",
	"belle-llama-13b-2m-v1",
	"chatyuan-large-v2",
}
local siliconflow_models = {
	"deepseek-ai/DeepSeek-R1",
	"deepseek-ai/DeepSeek-V3",
	"Pro/deepseek-ai/DeepSeek-R1",
	"Pro/deepseek-ai/DeepSeek-V3",
	"deepseek-ai/DeepSeek-R1-Distill-Llama-70B",
	"deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
	"Qwen/Qwen2.5-Coder-32B-Instruct",
	"Qwen/Qwen2-VL-72B-Instruct",
}
local deepseek_models = {
	"deepseek-chat",
	"deepseek-reasoner",
}
local bytedance_models = {
	"Doubao-pro-4k",
	"Doubao-pro-32k",
	"Doubao-pro-128k",
	"Doubao-pro-256k",
	"Doubao-lite-4k",
	"Doubao-lite-32k",
	"Doubao-lite-128k",
	"DeepSeek-R1",
	"DeepSeek-V3",
	"DeepSeek-R1-Distill-Qwen-32B",
}
local xunfei_models = {
	"Spark-Lite",
	"Spark-Pro",
	"Spark-Pro-128K",
	"Spark-Max",
	"Spark-Max-32K",
	"Spark-4.0-Ultra",
}
local yi_models = {
	"yi-lightning",
	"yi-large",
	"yi-large-turbo",
	"yi-medium",
}
local zhipu_models = {
	"glm-4-plus",
	"glm-4.6",
	"glm-4.7",
}
local gemini_models = {
	"gemini-2.5-pro",
	"gemini-2.5-flash",
	"gemini-2.5-flash-lite",
	"gemini-3-pro-preview",
}
local openai_models = {
	"gpt-3.5-turbo",
	"gpt-4",
	"gpt-4o",
	"gpt-4-turbo",
	"gpt-4o-mini",
	"gpt-5.1-2025-11-13",
	"gpt-5-2025-08-07",
	"gpt-5-mini-2025-08-07",
}
local openrouter_models = {
	"openai/gpt-3.5-turbo",
	"openai/chatgpt-4o-latest",
	"openai/o1",
	"openai/o3-mini",
	"google/gemini-2.0-flash-001",
	"google/gemini-2.0-flash-thinking-exp:free",
	"google/gemini-2.0-flash-lite-preview-02-05:free",
	"google/gemini-2.0-pro-exp-02-05:free",
	"google/gemini-flash-1.5-8b",
	"google/gemini-3-pro-preview",
  "google/gemini-3-pro-image-preview",
	"anthropic/claude-3.5-sonnet",
	"anthropic/claude-3.5-haiku",
	"google/gemma-3-27b-it:free",
	"anthropic/claude-sonnet-4.5",
	"anthropic/claude-3.7-sonnet",
	"openai/gpt-5-mini",
	"openai/gpt-5",
	"openai/gpt-5.1",
	"openai/gpt-5.1-chat",
	"openai/gpt-5.2",
	"openai/gpt-5.2-chat",
	"x-ai/grok-4-fast",
	"X-ai/grok-code-fast-1",
	"x-ai/grok-4",
	"google/gemini-2.5-pro",
	"x-ai/grok-3",
	"anthropic/claude-sonnet-4",
	"google/gemma-3n-e4b-it:free",
	"google/gemma-3n-e4b-it",
}

local oneapi_current_model = "deepseek-chat"
local get_oneapi_current_model = function()
	return oneapi_current_model
end
local oneapi_models = {}
for _, model in ipairs(aliyun_bailian_models) do
	table.insert(oneapi_models, "阿里百炼: " .. model)
end
for _, model in ipairs(siliconflow_models) do
	table.insert(oneapi_models, "硅基流动: " .. model)
end
for _, model in ipairs(deepseek_models) do
	table.insert(oneapi_models, "深度求索: " .. model)
end
for _, model in ipairs(bytedance_models) do
	table.insert(oneapi_models, "字节火山: " .. model)
end
for _, model in ipairs(xunfei_models) do
	table.insert(oneapi_models, "讯飞星火: " .. model)
end
for _, model in ipairs(yi_models) do
	table.insert(oneapi_models, "零一万物: " .. model)
end
for _, model in ipairs(zhipu_models) do
	table.insert(oneapi_models, "智谱AI: " .. model)
end
for _, model in ipairs(openrouter_models) do
	table.insert(oneapi_models, "OpenRouter: " .. model)
end
for _, model in ipairs(gemini_models) do
	table.insert(oneapi_models, "Gemini: " .. model)
end
for _, model in ipairs(openai_models) do
	table.insert(oneapi_models, "OpenAI: " .. model)
end

vim.api.nvim_create_user_command("CodeCompanionChangeModel", function()
	require("configs.ai.codecompanion").change_model()
end, {})

local oneapi_change_models_default = function()
	local models = vim.deepcopy(oneapi_models)
	vim.ui.select(models, { prompt = "切换AI模型(" .. oneapi_current_model .. ")" }, function(selected)
		if selected ~= nil then
			selected = selected:gsub(".*: ", "")
			oneapi_current_model = selected
		end
	end)
end

-- 切换模型使用telescope选择
local function oneapi_change_models(opts)
	local telescope = require("telescope")
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local sorters = require("telescope.sorters")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	opts = opts or {}
	pickers
		.new(opts, {
			prompt_title = "切换AI模型(" .. oneapi_current_model .. ")",
			finder = finders.new_table({
				results = oneapi_models,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry,
						ordinal = entry,
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						oneapi_current_model = selection.value:gsub(".*: ", "")
					end
				end)
				return true
			end,
		})
		:find()
end

local M = {
	-- 弹出UI列出所有的models，让用户选择一个大模型
	-- change_model = oneapi_change_models_default,
	change_model = oneapi_change_models,
}

M.lazy_config = {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- 聊天界面使用markdown渲染
		{
			"MeanderingProgrammer/render-markdown.nvim",
			ft = { "markdown", "codecompanion" },
		},
		-- 支持mcp
		"ravitemer/mcphub.nvim",
		-- 历史记录
		"ravitemer/codecompanion-history.nvim",
		-- 代码对比，使用 @insert_edit_into_file
		{
			"echasnovski/mini.diff",
			config = function()
				local diff = require("mini.diff")
				diff.setup({
					source = diff.gen_source.none(),
				})
			end,
		},
		-- 粘贴图片到buffer中
		{
			"HakonHarnes/img-clip.nvim",
			opts = {
				filetypes = {
					codecompanion = {
						prompt_for_file_name = false,
						template = "[Image]($FILE_PATH)",
						use_absolute_path = true,
					},
				},
			},
		},
	},
	config = function()
    -- 系统提示词可以看codecompanion仓库init.lua中SYSTEM_PROMPT
		require("codecompanion").setup({
			opts = {
				log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
				send_code = true,
				language = "Chinese",
			},
			strategies = {
				chat = {
					adapter = "oneapi",
					roles = {
						llm = function(adapter)
							return "雷总 (" .. adapter.schema.model.default() .. ")"
						end,
						-- user = os.getenv("USER"),
						user = "小雷",
					},
				},
				inline = {
					adapter = "oneapi",
				},
			},
			display = {
				inline = {
					-- vertical|horizontal|buffer
					layout = "vertical",
				},
				diff = {
					enabled = false,
				},
			},
			adapters = {
				http = {
					-- 融合各大模型API
					oneapi = function()
						return require("codecompanion.adapters").extend("openai", {
							name = "oneapi",
							formatted_name = "oneapi",
							env = {
								api_key = vim.env.ONE_API_KEY,
							},
							url = "http://127.0.0.1:3000/v1/chat/completions",
							schema = {
								model = {
									default = get_oneapi_current_model,
								},
								choices = oneapi_models,
							},
						})
					end,
					deepseek = function()
						return require("codecompanion.adapters").extend("deepseek", {
							env = {
								api_key = vim.env.DEEPSEEK_API_KEY,
							},
						})
					end,
					siliconflow = function()
						return require("codecompanion.adapters").extend("openai", {
							name = "siliconflow",
							formatted_name = "siliconflow",
							env = {
								api_key = vim.env.SILICONFLOW_API_KEY,
							},
							url = "https://api.siliconflow.cn/v1/chat/completions",
							schema = {
								model = {
									default = get_oneapi_current_model,
									choices = siliconflow_models,
								},
							},
						})
					end,
					aliyun_bailian = function()
						return require("codecompanion.adapters").extend("openai", {
							name = "aliyun_bailian",
							formatted_name = "aliyun_bailian",
							env = {
								api_key = vim.env.ALIYUN_BAILIAN_API_KEY,
							},
							url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
							schema = {
								model = {
									default = get_oneapi_current_model,
									choices = aliyun_bailian_models,
								},
							},
						})
					end,
				},
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
				-- 在命令行中读取API_kEY的配置方式，更安全
				acp = {},
			},
			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_vars = true,
						make_slash_commands = true,
						show_result_in_chat = true,
					},
				},
				history = {
					enabled = true,
					opts = {
						-- 打开历史记录buffer
						keymap = "gh",
						save_chat_keymap = "sc",
						auto_save = true,
						picker = "telescope",
						expiration_days = 0,
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
					},
				},
			},
		})
	end,
}

return M
