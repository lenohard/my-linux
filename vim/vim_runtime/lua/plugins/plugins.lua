return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
		opts = {
			-- add any opts here
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below is optional, make sure to setup it properly if you have lazy=true
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	-- UI and Themes
	{ "vim-airline/vim-airline" },
	{ "vim-airline/vim-airline-themes" },
	{ "nanotech/jellybeans.vim" },
	{ "morhetz/gruvbox" },
	{ "altercation/vim-colors-solarized" },
	{ "ap/vim-css-color" },

	-- File Navigation and Search
	{
		"scrooloose/nerdtree",
		cmd = "NERDTreeToggle",
		keys = {
			{ "<leader>nn", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
			{ "<leader>nb", ":NERDTreeFromBookmark<Space>", desc = "NERDTree from Bookmark" },
			{ "<leader>nf", ":NERDTreeFind<CR>", desc = "NERDTree Find" },
		},
	},
	{ "Xuyuanp/nerdtree-git-plugin", dependencies = { "scrooloose/nerdtree" } },
	{ "ctrlpvim/ctrlp.vim" },
	{
		"junegunn/fzf",
		build = function()
			vim.fn["fzf#install"]()
		end,
	},
	{ "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
	{ "mileszs/ack.vim" },
	{ "dyng/ctrlsf.vim" },

	-- Code Editing and Navigation
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "tpope/vim-commentary" },
	{ "tpope/vim-unimpaired" },
	{ "michaeljsmith/vim-indent-object" },
	{ "wellle/targets.vim" },
	{ "easymotion/vim-easymotion" },
	{ "andymass/vim-matchup" },

	-- Git Integration
	{ "tpope/vim-fugitive" },

	-- Language Support
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "github/copilot.vim" },
	{ "jose-elias-alvarez/null-ls.nvim" },

	-- Language-specific plugins
	{ "pangloss/vim-javascript" },
	{ "leafgarland/typescript-vim" },
	{ "maxmellon/vim-jsx-pretty" },
	{ "jparise/vim-graphql" },
	{ "neoclide/jsonc.vim" },
	{ "posva/vim-vue" },
	{ "lervag/vimtex" },
	{ "JuliaEditorSupport/julia-vim" },
	{ "neovimhaskell/haskell-vim" },
	{ "alx741/vim-hindent" },

	-- Misc
	{ "junegunn/vim-easy-align" },
	{ "junegunn/rainbow_parentheses.vim" },
	{ "Raimondi/delimitMate" },
	{ "xolox/vim-session", dependencies = { "xolox/vim-misc" } },
	{ "Chiel92/vim-autoformat" },
	{ "nanotee/zoxide.vim" },

	-- Neovim-specific plugins
	{
		"Vigemus/iron.nvim",
		cond = vim.fn.has("nvim") == 1,
	},
	{
		"Yggdroot/indentLine",
		cond = vim.fn.has("nvim") == 1,
	},
	{
		"ms-jpq/coq_nvim",
		branch = "coq",
		cond = vim.fn.has("nvim") == 1,
	},
	{
		"ms-jpq/coq.artifacts",
		branch = "artifacts",
		cond = vim.fn.has("nvim") == 1,
	},
	{
		"nvim-lua/plenary.nvim",
		cond = vim.fn.has("nvim") == 1,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cond = vim.fn.has("nvim") == 1,
	},

	-- Local plugins
	{ dir = "~/.vim_runtime/sources_forked/peaksea" },
	{ dir = "~/.vim_runtime/sources_forked/vim-peepopen" },
	{ dir = "~/.vim_runtime/sources_forked/vim-irblack-forked" },
}
