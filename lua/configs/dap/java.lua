local dap = require("dap")
local java_debug_port = 5005

local get_android_processes = function()
	local processes = {} -- 用于存储所有进程信息的表
	-- 执行命令并读取输出
	-- local handle = io.popen("adb shell 'ps -o USER,PID,NAME'")
	local handle = io.popen("adb shell 'ps -o USER,PID,NAME,COMMAND | grep 'app_process' | awk '{print $1, $2, $3}'")
	if not handle then
		vim.notify("无法执行 ps 命令", vim.log.levels.ERROR)
		return processes
	end

	-- 按行读取输出
	for line in handle:lines() do
		-- 忽略标题行
		-- if string.match(line, "^system") or string.match(line, "^u[0-9]+") then
		if string.match(line, "^system") or string.match(line, "^u[0-9]+") then
			-- 使用正则表达式解析 USER, PID, NAME
			local user, pid, name = string.match(line, "^(%S+)%s+(%d+)%s+(.+)$")
			if user and pid and name then
				-- 将解析到的信息存入表中
				table.insert(processes, {
					user = (user == "system" and "u0 " or user:gsub("_.*", "")),
					pid = tonumber(pid),
					name = name,
				})
			end
		end
	end

	-- 关闭 IO 句柄
	handle:close()
	return processes
end

-- 选择某个进程后，返回pid
local select_android_process = function(on_select)
	-- 选择要调试的进程
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local sorters = require("telescope.sorters")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local opts = {}
	local debug_processes = get_android_processes()
	if #debug_processes == 0 then
		vim.notify("未找到任何 Android 进程", vim.log.levels.WARN)
		return nil
	end

	pickers
		.new(opts, {
			prompt_title = "选择调试进程",
			finder = finders.new_table({
				results = debug_processes,
				entry_maker = function(entry)
					return {
						value = entry.pid,
						display = string.format("%s %5d %s", entry.user, entry.pid, entry.name),
						ordinal = entry.name,
					}
				end,
			}),
			sorter = sorters.get_generic_fuzzy_sorter(),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)
					if selection then
						print("pid: " .. selection.value)
						on_select(selection.value)
					end
				end)
				return true
			end,
		})
		:find()
end

local get_project_name_from_dot_project = function()

end

-- 注册一个任务模板
local android_debug_forward_task = "adb_forward_for_java_debug"

require("overseer").register_template({
	condition = {
		callback = function()
			local device_count = tonumber(vim.fn.system("adb devices | grep 'device$' | wc -l"))
			if device_count == 1 then
				return true
			else
				vim.notify("请连接一台Android设备", vim.log.levels.ERROR)
			end
		end,
	},
	name = android_debug_forward_task,
	params = {
		pid = {
			type = "string",
			desc = "Android PID to debug",
		},
	},
	builder = function(params)
		return {
			cmd = { "sh", "-c", string.format("adb forward tcp:%d jdwp:%s", java_debug_port, params.pid) },
			name = "Android adb Forward for Java Debug",
		}
	end,
})

dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		name = "Attach Java Debug",
		hostName = "127.0.0.1",
		port = java_debug_port,
	},
	-- 调试安卓java程序
	{
		type = "java",
		request = "attach",
		name = "Attach Android Debug",
		hostName = "127.0.0.1",
		port = java_debug_port,
		preLaunchTask = android_debug_forward_task,
    -- projectName = function()
    --   return "aosp"
    -- end
		-- postDebugTask = function()
		-- 	-- 移除端口转发
		-- 	vim.cmd(string.format("!adb forward --remove tcp:%d", java_debug_port))
		-- end,
	},
}
dap.listeners.after["event_terminated"]["clean_port"] = function()
	-- 双重保障：当调试意外终止时也执行清理
	-- vim.cmd(string.format("!adb forward --remove tcp:%d", java_debug_port))
end
-- 在debugger配置中增加超时检测
-- dap.defaults.java.auto_continue_if_many_stopped = false
-- dap.adapters.java = {
-- 	type = "server",
-- 	host = "127.0.0.1",
-- 	port = java_debug_port,
-- 	timeout = 3000, -- 3秒连接超时
-- }
