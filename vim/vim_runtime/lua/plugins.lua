return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Simple plugins can be specified as strings
    use '9mm/vim-closer'

    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "nvim-cmp" },
    }

    use{
        "zbirenbaum/copilot.lua",
        event = {"VimEnter"},
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
        server_opts_overrides = { trace = "verbose", name = "AI" },
        ft_disable = { "markdown", "terraform" },
    }
end)
