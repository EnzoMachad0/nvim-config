return {
    "mattn/emmet-vim",
    config = function()
        vim.g.user_emmet_leader_key = "<C-Y>,"  -- Líder personalizado para acionar o Emmet
    end,
    ft = { "html", "css", "javascript" }      -- Ativado apenas para arquivos relevantes
}
