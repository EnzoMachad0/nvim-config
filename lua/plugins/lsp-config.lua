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
                ensure_installed = { "gopls", "lua_ls", "html", "cssls", "ts_ls", "clangd" },
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Função on_attach para configurações comuns
            local on_attach = function(client, bufnr)
                client.server_capabilities.signatureHelpProvider = false -- Desativa o provedor de ajuda de assinatura (opcional)

                -- Mapas de teclas para comandos do LSP
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, bufopts)

                -- Autoformatação ao salvar
                if client.server_capabilities.documentFormattingProvider then
                    vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })]])
                end
            end

            -- Configurar capabilities para nvim-cmp
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Configurações do LSP para diferentes linguagens
            lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
            lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })

            -- Configuração para Go
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
        end
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier,     -- Formatação com Prettier
                    null_ls.builtins.formatting.clang_format, -- Formatação com Clang
                    null_ls.builtins.diagnostics.eslint,      -- Linter com ESLint
                },
                on_attach = function(client, bufnr)
                    -- Autoformatação ao salvar
                    if client.supports_method("textDocument/formatting") then
                        vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })]])
                    end
                end,
            })
        end
    }
}
