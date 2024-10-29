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

vim.o.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>t", ":terminal<CR>", {})
vim.keymap.set("n", "<leader>sp", ":sp<CR>", {})
vim.keymap.set("n", "<leader>vsp", ":vsp<CR>", {})
vim.keymap.set('i', '<Esc>', '<Esc>', {})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})
vim.keymap.set('n', '<leader>cp', ':Copilot enable<CR>', {})
vim.keymap.set('n', '<leader>ds', ':Copilot disable<CR>', {})

vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})
