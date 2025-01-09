return {
    {
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            -- Configure o nvim-treesitter
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "html", "javascript", "typescript", "vue", "svelte", "xml" }, -- Linguagens suportadas
                highlight = {
                    enable = true, -- Ativa o destaque de sintaxe
                },
            })

            -- Configure o nvim-ts-autotag diretamente
            require("nvim-ts-autotag").setup()
        end,
        ft = { "html", "javascriptreact", "typescriptreact", "vue", "svelte", "xml" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
}

