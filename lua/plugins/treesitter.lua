return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = { "lua", "javascript", "python", "typescript", "c", "cpp", "html", "css", "go", "java", "rust", "sql", },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
