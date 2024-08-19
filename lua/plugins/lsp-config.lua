return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "harper_ls", "sqls", "clangd", "gopls", "templ",},

            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.harper_ls.setup({})
            lspconfig.sqls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.gopls.setup({})
            lspconfig.templ.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})

        end
    }
}
