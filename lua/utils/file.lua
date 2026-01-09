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

M.file_exists = function(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    end
    return false
end

-- 检查文件大小
function M.current_file_size_mb()
  local size = vim.fn.getfsize(vim.fn.expand('%'))
  if size <= 0 then return 0 end
  return math.floor(size / 1024 / 1024)
end

return M
