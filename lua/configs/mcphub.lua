local setup = {
	-- 自动允许mcp调用
	auto_approve = function(params)
		-- 自动允许github issue获取
		if params.server_name == "github" and params.tool_name == "get_issue" then
			return true
		end
		-- 自动允许网页访问
		if params.server_name == "playwright" then
			return true
		end
		-- 自动允许获取时间
		if params.server_name == "time" then
			return true
		end
		-- Block access to private repos
		if params.arguments.repo == "private" then
			return "You can't access my private repo" -- Error message
		end

		-- Auto-approve safe file operations in current project
		if params.tool_name == "read_file" then
			local path = params.arguments.path or ""
			if path:match("^" .. vim.fn.getcwd()) then
				return true
			end
		end

		-- Check if tool is configured for auto-approval in servers.json
		if params.is_auto_approved_in_server then
			return true
		end

		return false -- Show confirmation prompt
	end,
	global_env = {
		REPOSITORY_PATH = vim.fn.getcwd(),
		ALLOWED_DIRECTORY = vim.fn.getcwd(),
		REDIS_URL = "http://localhost:6379",
	},
	config = vim.fn.expand("~/.config/nvim/data/mcpservers.json"),
	log = {
		level = vim.log.levels.WARN,
		to_file = true, -- log file: ~/.local/share/nvim/mcphub.log
		file_path = vim.fn.stdpath("data") .. "/mcphub.log",
	},
	on_ready = function()
		vim.notify("MCP Hub backend server is initialized and ready.", vim.log.levels.INFO)
	end,
}

require("mcphub").setup(setup)
