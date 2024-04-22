-- Open vim file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move highlighted text with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Replace current hovered word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Give run permission to current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- LSP Remaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

-- Format
local bufopts = { noremap = true, silent = true, buffer = bufnr }
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
