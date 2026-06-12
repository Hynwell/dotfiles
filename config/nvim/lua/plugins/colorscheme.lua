return {
    {
        "catppuccin/nvim",
        name     = "catppuccin",
        priority = 1000,
        lazy     = false,
        opts = {
            flavour          = "mocha",
            transparent_background = false,
            integrations = {
                cmp        = true,
                gitsigns   = true,
                neotree    = true,
                telescope  = { enabled = true },
                treesitter = true,
                which_key  = true,
                mason      = true,
                lsp_trouble = false,
                indent_blankline = { enabled = true },
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
