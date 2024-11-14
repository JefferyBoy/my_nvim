local util = require "formatter.util"

require("formatter").setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    c = require("formatter.filetypes.c").clangformat,
    cpp = require("formatter.filetypes.cpp").clangformat,
    lua = require("formatter.filetypes.lua").stylua,
    cmake = require("formatter.filetypes.cmake").cmakeformat,
    dart = require("formatter.filetypes.dart").dartformat,
    go = require("formatter.filetypes.go").gofmt,
    css = require("formatter.defaults").prettierd,
    html = require("formatter.defaults").prettierd,
    typescript = require("formatter.defaults").prettierd,
    typescriptreact = require("formatter.defaults").prettierd,
    vue = require("formatter.defaults").prettier,
    javascript = require("formatter.defaults").prettierd,
    javascriptreact = require("formatter.defaults").prettierd,
    json = require("formatter.defaults").prettierd,
    markdown = require("formatter.defaults").prettierd,
    java = require("formatter.filetypes.java").clangformat,
    kotlin = require("formatter.filetypes.kotlin").ktlint,
    proto = require("formatter.filetypes.proto").buf_format,
    python = require("formatter.filetypes.python").autopep8,
    rust = require("formatter.filetypes.rust").rustfmt,
    sh = require("formatter.filetypes.sh").shfmt,
    sql = {
      exe = "sqlfmt",
      args = {
        "--no-color",
        "--no-progressbar",
        "-q",
      },
      stdin = true,
      ignore_exitcode = true,
    },
    xhtml = require("formatter.filetypes.xhtml").tidy,
    xml = require("formatter.filetypes.xml").tidy,
    yaml = require("formatter.filetypes.yaml").yamlfmt,
    zsh = require("formatter.filetypes.yaml").yamlfmt,
  }
})
