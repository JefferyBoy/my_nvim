-- 自动加载环境变量
-- 变量读取：vim.env.VAR_NAME
local function load_environment()
	local env_path = vim.fn.stdpath("config") .. "/data/environment"
	local file = io.open(env_path, "r")
	if not file then
		return
	end

	for line in file:lines() do
		-- 跳过空行和注释
		line = line:gsub("#.*", ""):gsub("^%s*(.-)%s*$", "%1")
		if line ~= "" then
			local key, value = line:match("^([%w_]+)%s*=%s*(.*)$")
			if key and value then
				-- 去除可能的引号（支持 '...' 或 "..."）
				value = value:gsub("^[\"'](.*)[\"']$", "%1")
				vim.env[key] = vim.fn.expand(value)
			end
		end
	end

	file:close()
end

load_environment()
