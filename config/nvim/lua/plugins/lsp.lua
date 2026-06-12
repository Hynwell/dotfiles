return {
    -- Mason: install LSP servers / linters / formatters
    {
        "williamboman/mason.nvim",
        cmd  = "Mason",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "marksman",
                "shellcheck",
                "stylua",
                "shfmt",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            mr.refresh(function()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end)
        end,
    },

    -- LSP config (native vim.lsp API, nvim 0.11+)
    {
        "neovim/nvim-lspconfig",
        event        = { "BufReadPost", "BufNewFile" },
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local caps = require("cmp_nvim_lsp").default_capabilities()
            vim.lsp.config("*", { capabilities = caps })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime   = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME },
                        },
                        diagnostics = { globals = { "vim" } },
                        telemetry   = { enable = false },
                    },
                },
            })
            vim.lsp.config("marksman", {})

            vim.lsp.enable({ "lua_ls", "marksman" })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local map = function(keys, fn, desc)
                        vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = "LSP: " .. desc })
                    end
                    map("gd",         vim.lsp.buf.definition,  "Go to definition")
                    map("gD",         vim.lsp.buf.declaration, "Go to declaration")
                    map("gr",         vim.lsp.buf.references,  "References")
                    map("K",          vim.lsp.buf.hover,       "Hover docs")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("<leader>rn", vim.lsp.buf.rename,      "Rename")
                end,
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event        = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp     = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"]   = cmp.mapping.select_next_item(),
                    ["<C-p>"]   = cmp.mapping.select_prev_item(),
                    ["<C-b>"]   = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]   = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]   = cmp.mapping.abort(),
                    ["<CR>"]    = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- Linting (shellcheck for bash)
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                sh  = { "shellcheck" },
                bash = { "shellcheck" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        opts  = {
            formatters_by_ft = {
                lua = { "stylua" },
                sh  = { "shfmt" },
                bash = { "shfmt" },
            },
            format_on_save = nil, -- manual: <leader>cf
        },
    },
}
