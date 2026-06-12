return {
    -- Auto-close brackets/quotes
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts  = { check_ts = true },
    },

    -- Comment with gcc / gc
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts  = {},
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main  = "ibl",
        opts  = {
            indent = { char = "│" },
            scope  = { enabled = true },
        },
    },

    -- Git signs in gutter
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts  = {
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "" },
                topdelete    = { text = "" },
                changedelete = { text = "▎" },
                untracked    = { text = "▎" },
            },
            on_attach = function(buffer)
                local gs = package.loaded.gitsigns
                local map = function(mode, l, r, desc)
                    vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
                end
                map("n", "]h", gs.next_hunk,        "Next hunk")
                map("n", "[h", gs.prev_hunk,        "Prev hunk")
                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>gr", gs.reset_hunk,   "Reset hunk")
                map("n", "<leader>gb", gs.blame_line,   "Blame line")
            end,
        },
    },
}
