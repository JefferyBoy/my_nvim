return {
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
