return {
    {
        "nvim-telescope/telescope.nvim",
        cmd          = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond  = function() return vim.fn.executable("make") == 1 end,
            },
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>",              desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>",               desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>",                 desc = "Buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>",               desc = "Help tags" },
            { "<leader>fr", "<cmd>Telescope oldfiles<CR>",                desc = "Recent files" },
            { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Search in buffer" },
        },
        opts = {
            defaults = {
                prompt_prefix   = "  ",
                selection_caret = " ",
                mappings = {
                    i = { ["<C-q>"] = "send_to_qflist" },
                },
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("fzf")
        end,
    },
}
