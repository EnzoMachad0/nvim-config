return {
    "turbio/bracey.vim",
    build = "npm install --prefix server", -- Instala dependências do Bracey
    cmd = { "Bracey", "BraceyStop", "BraceyReload" },
    ft = { "html", "css", "javascript" },
    init = function()
        -- Configurações personalizadas do Bracey
        vim.g.bracey_server_port = 4000
        vim.g.bracey_browser_command = "firefox"
    end
}
