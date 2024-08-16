vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4") 
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- Última versão estável
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

require("lazy").setup("plugins")


--vim.cmd[[colorscheme tokyonight-moon]]


vim.o.clipboard = "unnamedplus"


