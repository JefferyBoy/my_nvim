require("catppuccin").setup({
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
    color_overrides = {
		  mocha = {
		  	rosewater = "#efc9c2",
		  	flamingo = "#ebb2b2",
		  	pink = "#f2a7de",
		  	mauve = "#b889f4",
		  	red = "#ea7183",
		  	maroon = "#ea838c",
		  	peach = "#f39967",
		  	yellow = "#eaca89",
		  	green = "#96d382",
		  	teal = "#78cec1",
		  	sky = "#91d7e3",
		  	sapphire = "#68bae0",
		  	blue = "#739df2",
		  	lavender = "#a0a8f6",
		  	text = "#b5c1f1",
		  	subtext1 = "#a6b0d8",
		  	subtext0 = "#959ec2",
		  	overlay2 = "#848cad",
		  	overlay1 = "#717997",
		  	overlay0 = "#63677f",
		  	surface2 = "#505469",
		  	surface1 = "#3e4255",
		  	surface0 = "#2c2f40",
		  	base = "#1a1c2a",
		  	mantle = "#141620",
		  	crust = "#0e0f16",
		  },
      -- mocha = {
      --   base = "#1c1917",
      --   blue =  "#22d3ee",
      --   green = "#86efac",
      --   flamingo = "#D6409F",
      --   lavender = "#DE51A8",
      --   pink = "#f9a8d4",
      --   red = "#fda4af",
      --   maroon = "#f87171",
      --   mauve = "#D19DFF",
      --   text = "#E8E2D9",
      --   sky = "#7ee6fd",
      --   yellow = "#fde68a",
      --   rosewater = "#f4c2c2",
      --   peach = "#fba8c4",
      --   teal = "#4fd1c5"
      -- }
	},
})

vim.cmd.colorscheme "catppuccin-mocha"
-- 设置搜索结果高亮颜色
vim.cmd("highlight Search guibg=#eaca89 guifg=#141620")
vim.cmd("highlight CursorLine guibg=#303030")
