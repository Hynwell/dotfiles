return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch  = "master",
        build   = ":TSUpdate",
        event   = { "BufReadPost", "BufNewFile" },
        opts = {
            ensure_installed = {
                "bash", "lua", "yaml", "markdown", "markdown_inline",
                "dockerfile", "json", "toml", "vim", "vimdoc",
                "gitignore", "gitcommit", "diff", "regex",
            },
            highlight    = { enable = true },
            indent       = { enable = true },
            auto_install = true,
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
