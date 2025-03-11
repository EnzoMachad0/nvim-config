return {
    "mattn/emmet-vim",
    config = function()
        vim.g.user_emmet_leader_key = "<C-Y>," -- Atalho para acionar Emmet
        vim.g.user_emmet_settings = {
            html = {
                default_attributes = {
                    meta = { name = "viewport", content = "width=device-width, initial-scale=1.0" }
                }
            }
        }
    end,
    ft = { "html", "css", "javascript", "jsx", "typescriptreact" }
}
