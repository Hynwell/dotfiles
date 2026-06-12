return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy     = false,
        opts = {
            style       = "night",
            transparent = false,
            styles      = { sidebars = "dark", floats = "dark" },
            on_colors = function(c)
                c.bg            = "#0d0d0d"
                c.bg_dark       = "#0a0a0a"
                c.bg_float      = "#0a0a0a"
                c.bg_sidebar    = "#0a0a0a"
                c.bg_statusline = "#0a0a0a"
                c.bg_popup      = "#0a0a0a"
            end,
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },
}
