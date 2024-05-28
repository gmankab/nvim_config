vim.keymap.set('n', '<C-v>', 'p',                { desc = 'paste' })
vim.keymap.set('n', '<C-;>', ':',                { desc = 'open command mode' })
vim.keymap.set('n', '<C-q>', ':qa!<CR>',          { desc = 'quit' })
vim.keymap.set('n', '<A-c>', ':bd!<CR>',          { desc = 'close buffer' })
vim.keymap.set('i', '<C-v>', '<C-r>+',           { desc = 'paste' })
vim.keymap.set('c', '<C-v>', '<C-r>+',           { desc = 'paste' })
vim.keymap.set('v', '<C-k>', vim.cmd.stop,       { desc = 'to normal mode' })
vim.keymap.set('i', '<C-k>', vim.cmd.stopinsert, { desc = 'to normal mode' })

