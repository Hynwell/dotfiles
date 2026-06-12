return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts  = {
            plugins = { spelling = false },
            defaults = {},
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>f",  group = "Find (telescope)" },
                { "<leader>c",  group = "Code" },
                { "<leader>s",  group = "Split" },
                { "<leader>b",  group = "Buffer" },
            })
        end,
    },
}
