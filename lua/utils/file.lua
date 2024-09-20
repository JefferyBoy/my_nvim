local M = {}

-- 获取路径
M.get_file_path = function(filename)
	return string.match(filename, "(.+)/[^/]*%.%w+$")
	-- return string.match(filename, “(.+)\\[^\\]*%.%w+$”) — windows
end

-- 获取文件名
M.get_file_name = function(filename)
	return string.match(filename, ".+/([^/]*%.%w+)$")
	-- return string.match(filename, “.+\\([^\\]*%.%w+)$”) — *nix system
end

-- 去除扩展名
M.remove_extension = function(filename)
	local idx = filename:match(".+()%.%w+$")
	if idx then
		return filename:sub(1, idx - 1)
	else
		return filename
	end
end

-- 获取扩展名
M.get_extension = function(filename)
	return filename:match(".+%.(%w+)$")
end

return M
