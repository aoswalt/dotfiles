require("oil").setup()

vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

vim.keymap.set('n', '<leader>x', '<cmd>vsp | Oil %:p:h | wincmd =<cr>', { silent = true })
vim.keymap.set('n', '<leader>X', '<cmd>sp | Oil %:p:h | wincmd =<cr>', { silent = true })
