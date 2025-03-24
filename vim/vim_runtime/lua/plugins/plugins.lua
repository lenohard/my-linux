return {
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
		config = function()
			require("diffview").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- Important: This runs the update command after installation
		config = function()
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"python",
					"javascript",
					"typescript",
					"html",
					"css",
					"json",
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
				highlight = {
					enable = true,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		event = "BufRead",
		config = function()
			require("diffview").setup()
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("nvim-navic").setup()
		end,
	},
	{
		-- gitsigns
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true, -- Enable inline blame
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = true, -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
	-- sqls.nvim
	{
		"nanotee/sqls.nvim",
		ft = "sql",
	},

	-- minimap.vim
	{
		"wfxr/minimap.vim",
		run = "cargo install --locked code-minimap",
		cmd = "Minimap",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {},
	},
	{
		-- Hop
		"phaazon/hop.nvim",
		event = "BufRead",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	},
	-- Lazy
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"folke/trouble.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
		opts = {
			["openai"] = {
				model = "claude-3.7-sonnet@anthropic",
				endpoint = "https://api.unify.ai/v0",
				api_key_name = "OPENAI_API_KEY",
			},
			["gemini"] = {
				model = "gemini-2.0-pro-exp",
				api_key_name = "GEMINI_API_KEY",
				proxy = "http://127.0.0.1:6152",
			},
			["claude"] = {
				proxy = "http://127.0.0.1:6152",
			},
			windows = {
				position = "bottom",
				width = 100,
				height = 40,
			},
			-- add any opts here
			provider = "openai",
			vendors = {
				---@type AvanteProvider
				groq = {
					endpoint = "https://api.groq.com/openai/v1/chat/completions",
					model = "llama-3.1-70b-versatile",
					api_key_name = "GROQ_API_KEY",
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint,
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
								["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
							},
							body = {
								model = opts.model,
								messages = { -- you can make your own message, but this is very advanced
									{ role = "system", content = code_opts.system_prompt },
									{
										role = "user",
										content = require("avante.providers.openai").get_user_message(code_opts),
									},
								},
								temperature = 0,
								max_tokens = 4096,
								stream = true, -- this will be set by default.
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
				---@type AvanteProvider
				unity = {
					endpoint = "https://api.unify.ai/v0/chat/completions",
					model = "claude-3.7-sonnet@anthropic->aws-bedrock",
					api_key_name = "UNIFY_KEY",
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint,
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
								["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
							},
							body = {
								model = opts.model,
								messages = { -- you can make your own message, but this is very advanced
									{ role = "system", content = code_opts.system_prompt },
									{
										role = "user",
										content = require("avante.providers.openai").get_user_message(code_opts),
									},
								},
								temperature = 0,
								max_tokens = 4096,
								stream = true, -- this will be set by default.
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
				---@type AvanteProvider
				mify = {
					endpoint = "http://m2o.staging.xiaomi.srv/v1/chat/completions",
					model = "claude-3.7-sonne",
					api_key_name = "MIFY_KEY",
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint,
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
								["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
							},
							body = {
								model = opts.model,
								messages = { -- you can make your own message, but this is very advanced
									{ role = "system", content = code_opts.system_prompt },
									{
										role = "user",
										content = require("avante.providers.openai").get_user_message(code_opts),
									},
								},
								temperature = 0,
								max_tokens = 8096,
								stream = true, -- this will be set by default.
							},
						}
					end,
				},
				---@type AvanteProvider
				deepseek = {
					endpoint = "https://api.deepseek.com/chat/completions",
					model = "deepseek-coder",
					api_key_name = "DEEPSEEK_API_KEY",
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint,
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
								["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
							},
							body = {
								model = opts.model,
								messages = { -- you can make your own message, but this is very advanced
									{ role = "system", content = code_opts.system_prompt },
									{
										role = "user",
										content = require("avante.providers.openai").get_user_message(code_opts),
									},
								},
								temperature = 0,
								max_tokens = 4096,
								stream = true, -- this will be set by default.
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
				openrouter = {
					endpoint = "https://openrouter.ai/api/v1/chat/completions",
					model = "auto",
					api_key_name = "OPENROUTER_API_KEY",
					parse_curl_args = function(opts, code_opts)
						return {
							url = opts.endpoint,
							headers = {
								["Accept"] = "application/json",
								["Content-Type"] = "application/json",
								["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
							},
							body = {
								model = opts.model,
								messages = { -- you can make your own message, but this is very advanced
									{ role = "system", content = code_opts.system_prompt },
									{
										role = "user",
										content = require("avante.providers.openai").get_user_message(code_opts),
									},
								},
								temperature = 0,
								max_tokens = 4096,
								stream = true, -- this will be set by default.
							},
						}
					end,
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
			},
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
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			-- add options here
			-- or leave it empty to use the default settings
		},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
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
	-- { "vim-airline/vim-airline" },
	-- { "vim-airline/vim-airline-themes" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("lualine").setup({
				sections = {
					lualine_c = {
						{ "filename" },
						{
							function()
								return require("nvim-navic").get_location()
							end,
							cond = function()
								return require("nvim-navic").is_available()
							end,
						},
					},
				},
			})
		end,
	},
	{
		-- nightfox
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").load()
		end,
	},
	{
		-- colorizer
		"norcalli/nvim-colorizer.lua",
	},
	{
		"nanozuki/tabby.nvim",
		-- event = 'VimEnter', -- if you want lazy load, see below
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			-- configs...
		end,
	},
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
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
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {},
	},
	{ "mileszs/ack.vim" },
	-- { "dyng/ctrlsf.vim" },

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

	-- Smooth Scrolling
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},

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
	-- starttime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		keys = {
			{ "<leader>tt", ":StartupTime<CR>", desc = "Show startup time" },
		},
	},

	-- Local plugins
	{ dir = "~/.vim_runtime/sources_forked/peaksea" },
	{ dir = "~/.vim_runtime/sources_forked/vim-peepopen" },
	{ dir = "~/.vim_runtime/sources_forked/vim-irblack-forked" },
	{
		"elzr/vim-json",
		ft = { "json", "jsonc" }, -- 仅在打开 json 或 jsonc 文件时加载
		config = function()
			-- 可选的配置 (根据你的需要调整)
			vim.g.vim_json_syntax_conceal = 0 -- 禁用隐藏字符，更容易看到引号等
		end,
	},
	{
		"othree/yajs.vim",
		ft = { "json", "jsonc" },
	},
}
