local fileutil = require("utils.file")
return {
  name = "g++ build",
  builder = function ()
    local file = vim.api.nvim_buf_get_name(0)
    local filename = fileutil.remove_extension(fileutil.get_file_name(file))
    return {
      cmd = { "g++", "-g", "-o", filename },
      args = { file },
      components = {
        {
          "on_output_quickfix", open = true
        },
        "default"
      }
    }
  end,
  condition = {
    filetype = { "cpp" },
  }
}
