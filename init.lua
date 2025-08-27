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
vim.g.copilot_auto_start = false

vim.keymap.set("n", "<leader>t", ":terminal<CR>", {}) --abrir o terminal
vim.keymap.set("n", "<leader>sp", ":sp<CR>", {})      --divdir a tela horizontalmente
vim.keymap.set("n", "<leader>vsp", ":vsp<CR>", {})    -- dividir a tela verticalmente
vim.keymap.set('i', '<Esc>', '<Esc>', {})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {})
vim.keymap.set('n', '<leader>cp', ':Copilot enable<CR>', {})
vim.keymap.set('n', '<leader>ds', ':Copilot disable<CR>', {})

vim.keymap.set('n', '<C-h>', '<C-w>h', {})
vim.keymap.set('n', '<C-j>', '<C-w>j', {})
vim.keymap.set('n', '<C-k>', '<C-w>k', {})
vim.keymap.set('n', '<C-l>', '<C-w>l', {})
vim.keymap.set('n', '<leader>ya', 'gg0vGG$"+y', {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "cpp",
    callback = function()
        vim.keymap.set("i", "$cppmain", [[
#include <bits/stdc++.h>
using namespace std;

#define FAST_IO \
    ios_base::sync_with_stdio(0); \
    cin.tie(0);
#define endl '\n'
#define dbg(x) cout << #x << " = " << (x) << endl;
#define f first
#define s second
#define pb push_back

typedef long long ll;

int main(void) {
    FAST_IO
    return 0;
}
]], { noremap = true, silent = true, buffer = true })
    end
})
