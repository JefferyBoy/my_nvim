local present, nvterm = pcall(require, "nvterm")

if not present then
  return
end

local options = {
  terminals = {
    list = {},
    type_opts = {
      horizontal_1 = { location = "rightbelow", split_ratio = 0.08 },
      horizontal_2 = { location = "rightbelow", split_ratio = 0.08 },
      horizontal_3 = { location = "rightbelow", split_ratio = 0.08 },
      horizontal_4 = { location = "rightbelow", split_ratio = 0.08 },
      horizontal_5 = { location = "rightbelow", split_ratio = 0.08 },
    },
  },
  behavior = {
    close_on_exit = true,
    auto_insert = true,
  },
  enable_new_mappings = true,
}

nvterm.setup(options)
