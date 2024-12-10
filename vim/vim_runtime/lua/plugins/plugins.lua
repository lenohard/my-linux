return {
	{
		"SmiteshP/nvim-navic",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("nvim-navic").setup()
		end,
	},
	-- nvim-dap-python
	{
		"mfussenegger/nvim-dap-python",
		event = "BufRead",
		config = function()
			require("dap-python").setup("python3")
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ plugins = { "nvim-dap-ui" }, types = true },
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		event = "BufRead",
		config = function()
			require("dap").adapters.cpp = {
				type = "executable",
				attach = { pidProperty = "pid", pidSelect = "ask" },
				command = "lldb-vscode",
				name = "lldb",
			}
			require("dap").configurations.cpp = {
				{
					name = "Launch",
					type = "lldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
					args = {},
					runInTerminal = false,
				},
			}
		end,
	},
	-- nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		keys = {
			{ "<leader>ts", "<cmd>Telescope treesitter<CR>", desc = "Telescope Treesitter" },
			{ "<leader>tq", "<cmd>TSQuickfix<CR>", desc = "Treesitter Quickfix" },
			{ "<leader>tb", "<cmd>TSBufToggle highlight<CR>", desc = "Toggle Treesitter Highlight" },
		},
	},
	-- nvim-dap-virtual-text
	{
		"theHamsta/nvim-dap-virtual-text",
		event = "BufRead",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	-- nvim-dap-ui
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		keys = {
			-- 现有的 UI 控制快捷键
			{ "<leader>dd", "<cmd>lua require('dapui').toggle()<CR>", desc = "Toggle DAP UI" },
			{ "<leader>dc", "<cmd>lua require('dapui').close()<CR>", desc = "Close DAP UI" },
			{ "<leader>dh", "<cmd>lua require('dapui').float_element()<CR>", desc = "Float DAP UI" },
			{ "<leader>de", "<cmd>lua require('dapui').eval()<CR>", desc = "Evaluate DAP UI" },
			{ "<leader>ds", "<cmd>lua require('dapui').scopes()<CR>", desc = "Scopes DAP UI" },
			{ "<leader>dv", "<cmd>lua require('dapui').variables()<CR>", desc = "Variables DAP UI" },
			{ "<leader>dt", "<cmd>lua require('dapui').test()<CR>", desc = "Test DAP UI" },
			{ "<leader>dr", "<cmd>lua require('dapui').repl.toggle()<CR>", desc = "Toggle DAP REPL" },
			{ "<leader>dl", "<cmd>lua require('dapui').repl.run_last()<CR>", desc = "Run last DAP REPL" },

			-- 添加调试控制快捷键
			{ "<F5>", "<cmd>lua require('dap').continue()<CR>", desc = "Debug: Continue" },
			{ "<F10>", "<cmd>lua require('dap').step_over()<CR>", desc = "Debug: Step Over" },
			{ "<F11>", "<cmd>lua require('dap').step_into()<CR>", desc = "Debug: Step Into" },
			{ "<F12>", "<cmd>lua require('dap').step_out()<CR>", desc = "Debug: Step Out" },
			{ "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", desc = "Debug: Toggle Breakpoint" },
			-- {
			-- 	"<leader>dB",
			-- 	"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
			-- 	desc("Debug: Set Conditional Breakpoint"),
			-- },
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- 设置 dapui
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						position = "bottom",
						size = 10,
					},
				},
			})

			-- 当开始/结束调试会话时自动打开/关闭 dapui
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
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
				model = "claude-3.5-haiku@anthropic",
				endpoint = "https://api.unify.ai/v0",
				api_key_name = "OPENAI_API_KEY",
			},
			["gemini"] = {
				model = "gemini-1.5-pro-exp-0827",
				api_key_name = "GEMINI_API_KEY",
				proxy = "http://127.0.0.1:6152",
			},
			["claude"] = {
				proxy = "http://127.0.0.1:6152",
			},
			-- add any opts here
			provider = "openai",
			vendors = {
				---@type AvanteProvider
				perplexity = {
					endpoint = "https://api.perplexity.ai/chat/completions",
					model = "llama-3.1-sonar-large-128k-online",
					api_key_name = "PERPLEXITY_API_KEY",
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
								max_tokens = 8192,
								stream = true, -- this will be set by default.
							},
						}
					end,
					-- The below function is used if the vendors has specific SSE spec that is not claude or openai.
					parse_response_data = function(data_stream, event_state, opts)
						require("avante.providers").openai.parse_response(data_stream, event_state, opts)
					end,
				},
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
				unity = {
					endpoint = "https://api.unify.ai/v0/chat/completions",
					model = "claude-3.5-sonnet@anthropic->aws-bedrock",
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
}
