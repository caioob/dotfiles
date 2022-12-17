vim.g.mapleader = " "
-- Open vim file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move highlighted text with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle <C-d> and <C-u>
vim.keymap.set("n", "<C-d>","<C-d>zz")
vim.keymap.set("n", "<C-n>","<C-n>zz")

-- Keep cursor in the middle when searching
vim.keymap.set("n", "n","nzzzv")
vim.keymap.set("n", "N","Nzzzv")

-- Paste without replacing current yanked text
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Replace current hovered word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Give run permission to current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Run current shell script
vim.keymap.set("n", "<leader>r", "<cmd>!bash % <CR>", { silent = true })

