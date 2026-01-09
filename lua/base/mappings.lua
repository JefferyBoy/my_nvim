local ops_def = { noremap = true, silent = true }
local ops_ext = function(ext_ops)
	if ext_ops == nil then
		return ops_def
	end
	return vim.tbl_extend("force", ops_def, ext_ops)
end
local map = function(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, ops_ext(opts))
end
-- 普通模式
local n = "n"
-- 普通、选择模式
local nx = { "n", "x" }
-- 重新加载配置文件
map("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<CR>")
-- 窗口调整
map("n", "<C-up>", "<cmd>resize +5<CR>")
map("n", "<C-down>", "<cmd>resize -5<CR>")
map("n", "<C-left>", "<cmd>vertical resize -5<CR>")
map("n", "<C-right>", "<cmd>vertical resize +5<CR>")
--保存退出
map("n", "W", "<cmd>w<CR>")
map("n", "Q", "<cmd>q<CR>")
--键0回到行首非空字符位置
map("n", "0", "^")
--系统剪贴板
map("v", "Y", '"+y')
--分屏窗口移动
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<A-v>", "<cmd>vsp<CR>")
map("n", "<A-s>", "<cmd>sp<CR>")
--快速打开终端
map("n", "<C-t>", "<cmd>terminal zsh<CR>")
--buffer切换
map("n", "<A-l>", "<cmd>bprevious<CR>")
map("n", "<A-h>", "<cmd>bnext<CR>")
map("n", "<A-w>", "<cmd>bdelete<CR>")
--barbar
map("n", "<A-H>", "<Cmd>BufferMovePrevious<CR>")
map("n", "<A-L>", "<Cmd>BufferMoveNext<CR>")
map("n", "<A-W>", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>")
map("n", "<C-A-h>", "<Cmd>BufferCloseBuffersLeft<CR>")
map("n", "<C-A-l>", "<Cmd>BufferCloseBuffersRight<CR>")

--行号显示
map("n", "<leader>n", "<cmd>set nu!<CR>")
map("n", "<leader>rn", "<cmd>set rnu!<CR>")
--取消高亮
map("n", "<ESC>", "<cmd>noh<CR>")
--代码折叠
map("n", "<leader>zz", "<cmd>set foldmethod=indent<CR>")
map("n", "<leader>zm", "<cmd>set foldmethod=manual<CR>")
--切换自动换行
map("n", "<leader>wt", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "toggle wrap" })
--快速搜索 JefferyBoy/keyword_search.nvim
map("n", "ss", "<cmd>SearcheInWord false<CR>")
map("n", "sa", "<cmd>SearcheInWord true<CR>")
map("n", "sd", "<cmd>UnSearcheInWord<CR>")
map("n", "sn", "<cmd>SearcheCurrentBufferToNew<CR>")
map("n", "sN", "<cmd>SearcheAllFilesToNew<CR>")

--telescope
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
	map("n", "<leader>ff", builtin.find_files, { desc = "find files" })
	map("n", "<leader>fF", require("configs.telescope").find_files_in_word, { desc = "find files in word" })
	map("n", "<leader>fw", builtin.live_grep, { desc = "live grep" })
	map("n", "<leader>fW", builtin.grep_string, { desc = "grep string in word" })
	map("n", "<leader>fg", builtin.git_files, { desc = "find git files" })
	map("n", "<leader>fb", builtin.buffers, { desc = "find buffers" })
	map("n", "<leader>fh", builtin.help_tags, { desc = "find help tags" })
	map("n", "<leader>ft", "<cmd>Telescope colorscheme<CR>")
	map("n", "<leader>fp", "<cmd>Telescope projects<CR>")
	map("n", "<leader>fB", "<cmd>Telescope bookmarks<CR>")
	-- map("n", "<leader>fm", builtin.marks)
	map("n", "<f1>", builtin.commands)
	map("n", "<f2>", builtin.keymaps)
	map("n", "<f11>", builtin.buffers)
	map("n", "<f12>", builtin.lsp_document_symbols)
	map("n", "<C-e>", builtin.oldfiles)
	map("n", ";", "<cmd>Telescope cmdline<CR>")
end

--nvimtree
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>")

--git
map("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "lazygit" })
map("n", "<leader>gd", "<cmd>GitDiffFileChanges<CR>", { desc = "git file diff" })
map("n", "<leader>gl", "<cmd>GitDiffFileHistory<CR>", { desc = "git file history" })
map("n", "<leader>gb", "<cmd>GitDiffFileByBranch<CR>", { desc = "git file diff by branch" })

--lspconfig
local lsp = vim.lsp
map("n", "K", lsp.buf.hover)
map("n", "gd", lsp.buf.definition)
map("n", "gi", lsp.buf.implementation)
map("n", "gr", lsp.buf.references)
map("n", "gq", vim.diagnostic.setloclist)
map("n", "gh", function()
	lsp.buf.typehierarchy("supertypes")
end, { desc = "super type hierarchy" })
map("n", "gl", function()
	lsp.buf.typehierarchy("subtypes")
end, { desc = "sub type hierarchy" })
map("n", "<A-CR>", lsp.buf.code_action)
map("n", "<A-i>", lsp.buf.incoming_calls)
map("n", "<A-o>", lsp.buf.outgoing_calls)
-- map("n", "<A-s>", lsp.buf.signature_help)
-- map("n", "<leader>fs", lsp.buf.workspace_symbol, tbl_extend(ops, { desc = 'workspace symbol' }))
-- map('n', '<leader>fm', lsp.buf.format, tbl_extend(ops, { desc = 'format' }))
-- map("n", "<leader>wa", lsp.buf.add_workspace_folder, { desc = "add workspace folder" })
-- map("n", "<leader>wr", lsp.buf.remove_workspace_folder, { desc = "remove workspace folder" })
-- map("n", "<leader>wl", function()
-- 	print(vim.inspect(lsp.buf.list_workspace_folders()))
-- end, { desc = "list workspace folders" })

--终端toogleterm.nvim
local toggle_modes = { "n", "t" }
map(toggle_modes, "<A-f>", "<Cmd>6ToggleTerm direction=float<CR>")
map(toggle_modes, "<A-1>", "<Cmd>1ToggleTerm<CR>")
map(toggle_modes, "<A-2>", "<Cmd>2ToggleTerm<CR>")
map(toggle_modes, "<A-3>", "<Cmd>3ToggleTerm<CR>")
map(toggle_modes, "<A-4>", "<Cmd>4ToggleTerm<CR>")
map(toggle_modes, "<A-5>", "<Cmd>5ToggleTerm<CR>")

--renamer
map("n", "<leader>rn", "<cmd>RenameCurrentCursorField<CR>")
-- map('n', '<leader>rn', function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true })
-- map('v', '<leader>rn', function() return ":IncRename " .. vim.fn.expand("<cword>") end, { expr = true })

--formatter
map("n", "<leader>fm", "<cmd>Format<cr>")

--nvim-dap
local ok, dap = pcall(require, "dap")
if ok then
	local dapui = require("dapui")
	map("n", "<F7>", dap.step_into, { desc = "dap step into" })
	map("n", "<F8>", dap.step_over, { desc = "dap step over" })
	map("n", "<F9>", dap.continue, { desc = "dap continue" })
	map("n", "<F10>", dap.step_out, { desc = "dap step out" })
	map("n", "<leader>db", dap.toggle_breakpoint, { desc = "dap toggle breakpoint" })
	map("n", "<leader>dB", function()
		-- 条件断点表达式
		local condition = vim.fn.input("Breakpoint Condition: ")
		-- 条件触发多少次后再触发断点
		local condition_hit = nil
		-- 触发后打印日志（可以用{}包裹变量）
		local logMsg = vim.fn.input("Breakpoint Message: ")
		dap.set_breakpoint(condition, condition_hit, logMsg)
	end, { desc = "dap toggle breakpoint" })
	-- map("n", "<leader>dB", dap.clear_breakpoints, { desc = "dap clear breakpoints" })
	map("n", "<leader>dl", function()
		dap.list_breakpoints(true)
	end, { desc = "dap list breakpoints" })
	map("n", "<leader>dq", dap.terminate, { desc = "dap quit" })
	map("n", "<leader>dr", dap.continue, { desc = "dap continue(start)" })
	map("n", "<leader>dR", dap.restart, { desc = "dap restart" })
	map("n", "<leader>dt", dapui.toggle, { desc = "dap ui toggle" })
	map("n", "<leader>de", dapui.eval, { desc = "dap ui eval expression" })
	map("n", "<leader>dc", dap.run_to_cursor, { desc = "dap run to cursor" })
	map("n", "<leader>dd", "<cmd>Telescop dap commands<CR>", { desc = "dap commands" })
end

--todo
map("n", "<leader>td", "<cmd>TodoTelescope<cr>")

--翻译
map("n", "tw", "<cmd>TranslateW<cr>")
map("x", "ts", function()
	local w = vim.fn.eval("@*")
	vim.cmd("normal! “*y")
	vim.cmd("TranslateX")
	vim.cmd("let @* = " .. w)
end)

--代码outline
map("n", "{", "<cmd>AerialPrev<CR>", { buffer = 0 })
map("n", "}", "<cmd>AerialNext<CR>", { buffer = 0 })
map("n", "<C-m>", "<cmd>AerialToggle! right<CR>")
map("n", "<CR>", "<cmd>AerialNext<CR>", { buffer = 0 })
vim.keymap.del("n", "<CR>")

-- 任务管理obverseer
map("n", "<leader>tt", "<CMD>OverseerToggle<CR>")
map("n", "<leader>tr", "<CMD>OverseerRun<CR>")
map("n", "<leader>tR", "<CMD>OverseerRestartLast<CR>")
map("n", "<leader>tc", "<CMD>OverseerRunCmd<CR>")

-- nvim-jdtls
-- map("n", "<C-A-o>", require("jdtls").organize_imports)

--flash.nvim跳转
local ok, _ = pcall(require, "flash")
if ok then
	map({ "n", "x", "o" }, "F", require("flash").jump, { desc = "Flash.nvim" })
	-- map({ "n", "x", "o" }, "F", require("flash").treesitter, { desc = "Flash.nvim" })
end

----------------------------
------ AI编程辅助工具 ------
----------------------------
-- codeium
if vim.g.loaded_codeium ~= nil then
	map("n", "<leader>cc", "<cmd>Codeium Chat<CR>")
end
-- codecompanion
local ok, _ = pcall(require, "codecompanion")
if ok then
	map(nx, "<leader>cc", "<cmd>CodeCompanionChat Toggle<CR>")
	map(nx, "<leader>ca", "<cmd>Telescope codecompanion<CR>")
	map(nx, "<leader>cl", "<cmd>CodeCompanion /lsp<CR>")
	map(nx, "<leader>cb", "<cmd>CodeCompanion /fix<CR>")
	map(n, "<leader>ce", "<cmd>CodeCompanion /buffer<CR>")
	map(nx, "<leader>ct", "<cmd>CodeCompanion /tests<CR>")
	map(n, "<leader>cm", "<cmd>CodeCompanionChangeModel<CR>", { desc = "CodeCompanion 修改AI模型" })
	map(nx, "<leader>cx", "<cmd>CodeCompanion /explain<CR>")
	map(n, "<leader>cw", "<cmd>CodeCompanion /workflow<CR>")
	map(nx, "<leader>cs", "<cmd>CodeCompanion /translate<CR>")
end

-- bookmark_nvim书签保存
map("n", "<C-b>", "<cmd>BookmarkToggleSideBar<CR>")
