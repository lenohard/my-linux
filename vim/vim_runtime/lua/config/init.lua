require("mason").setup({})
require("mason-lspconfig").setup({})
-- use pyright for python
require("lspconfig").pyright.setup({})
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({
	root_dir = function(fname)
		-- Use the directory containing the file as the root if no project root is found
		return require("lspconfig").util.root_pattern(
			"pyrightconfig.json",
			"setup.py",
			"setup.cfg",
			"pyproject.toml",
			".git"
		)(fname) or vim.fn.fnamemodify(fname, ":p:h")
	end,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

local servers = { "pyright", "tsserver", "jsonls", "gopls" }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({})
end
-- Set up nvim-cmp.
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")
null_ls.setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black.with({
			extra_args = { "--line-length", "79" },
		}),
	},
})
