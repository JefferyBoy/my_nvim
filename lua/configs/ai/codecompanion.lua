local aliyun_bailian_models = {
	"qwen-plus",
	"qwen-max",
	"qwen-turbo",
	"qwen-long",
	"qwen-coder-plus",
	"qwen-72b-chat",
	"qwen-14b-chat",
	"deepseek-r1",
	"deepseek-v3",
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
	"glm-4-air",
	"glm-4-long",
}

local oneapi_current_model = "qwen-plus"
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
		{ "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
	},
	config = function()
		require("codecompanion").setup({
			opts = {
				log_level = "ERROR", -- TRACE|DEBUG|ERROR|INFO
				send_code = true,
				language = "Chinese",
				system_prompt = function()
					return 'You are an AI programming assistant named "雷总". Your all non-code responses must be in Chinese.'
				end,
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
			adapters = {
				-- 融合各大模型API
				oneapi = function()
					return require("codecompanion.adapters").extend("openai", {
						name = "oneapi",
						formatted_name = "oneapi",
						env = {
							api_key = "ONE_API_KEY",
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
							api_key = "ALIBAILIAN_API_KEY",
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
