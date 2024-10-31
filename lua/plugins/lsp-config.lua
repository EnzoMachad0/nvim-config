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
                ensure_installed = { "gopls", "lua_ls", "harper_ls", "templ", "clangd" },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Defina a função on_attach antes de usá-la
            local on_attach = function(client, bufnr)
                -- Desativa o provedor de ajuda de assinatura, se necessário
                client.server_capabilities.signatureHelpProvider = false

                -- Defina mapeamentos comuns para o LSP
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, bufopts)
            end

            -- Defina as capabilities, se necessário
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Configure os servidores LSP
            lspconfig.lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.harper_ls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.sqls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.clangd.setup({
                on_attach = on_attach, -- Use a função on_attach definida acima
                capabilities = capabilities,
            })
            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git", "."),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            })
            lspconfig.templ.setup({ on_attach = on_attach, capabilities = capabilities })
        end
    }
}
