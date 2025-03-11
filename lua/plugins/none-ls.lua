return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

        null_ls.setup({
            debug = true,
            sources = {
                -- Configurando Stylua (Lua) para 4 espaços de indentação
                null_ls.builtins.formatting.stylua.with({
                    extra_args = { "--indent-width", "4", "--indent-type", "Spaces" },
                }),

                -- Configurando Prettier (JS, TS, HTML, CSS) para 4 espaços de indentação
                null_ls.builtins.formatting.prettier.with({
                    extra_args = { "--tab-width", "4", "--use-tabs", "false" },
                }),

                -- Configurando clang_format (C, C++) para 4 espaços de indentação
                null_ls.builtins.formatting.clang_format.with({}),

                -- O Black (Python) já usa indentação de 4 espaços por padrão
                null_ls.builtins.formatting.black,

                -- Outros linters e formatadores
                null_ls.builtins.diagnostics.erb_lint,
                null_ls.builtins.formatting.goimports_reviser,
                null_ls.builtins.formatting.gofumpt,
            },

            on_attach = function(client, bufnr)
                -- Evita erro de compatibilidade com versões mais recentes do Neovim
                if client.supports_method and pcall(client.supports_method, client, "textDocument/formatting") then
                    -- Limpar autocomandos existentes para evitar duplicação
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

                    -- Criar um autocomando para formatar o buffer ao salvar
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            pcall(vim.lsp.buf.format, { bufnr = bufnr })
                        end,
                    })
                end
            end,
        })

        -- Mapeamento para formatar manualmente
        vim.keymap.set("n", "<leader>gf", function()
            pcall(vim.lsp.buf.format, { async = true })
        end, { noremap = true, silent = true })
    end,
}
