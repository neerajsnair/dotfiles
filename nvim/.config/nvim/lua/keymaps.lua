vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Last buffer" })

