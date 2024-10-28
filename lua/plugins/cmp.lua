-- Arquivo: lua/plugins/cmp.lua
-- Configuração completa do nvim-cmp com suporte para snippets, LSP e buffer

-- Função que retorna a configuração de nvim-cmp como uma tabela
local function get_cmp_config()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    return {
        snippet = {
            -- Expansão de snippet usando LuaSnip
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirmação com enter
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },  -- Fonte do LSP
            { name = "luasnip" },   -- Fonte de snippets
        }, {
            { name = "buffer" },    -- Fonte do buffer
            { name = "path" },      -- Fonte de caminho de arquivos
        }),
        formatting = {
            -- Configuração opcional de formatação das sugestões
            format = function(entry, vim_item)
                vim_item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },
    }
end

-- Setup do nvim-cmp com a tabela retornada
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-buffer" },        -- Sugestões de buffer
        { "hrsh7th/cmp-path" },          -- Sugestões de caminho
        { "hrsh7th/cmp-nvim-lsp" },      -- Sugestões com base no LSP
        { "hrsh7th/cmp-nvim-lua" },      -- Sugestões para Lua no Neovim
        { "saadparwaiz1/cmp_luasnip" },  -- Suporte para snippets
        { "L3MON4D3/LuaSnip" },          -- Engine de snippets
    },
    config = function()
        -- Configurar o nvim-cmp utilizando a função que retorna a tabela
        require("cmp").setup(get_cmp_config())

        -- Configuração opcional do LuaSnip para carregar snippets extras
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}

