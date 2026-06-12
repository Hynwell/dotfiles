return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        lazy     = false,
        opts = {
            theme       = "dragon",
            background  = { dark = "dragon" },
            dimInactive = true,
        },
        config = function(_, opts)
            require("kanagawa").setup(opts)
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },
}
