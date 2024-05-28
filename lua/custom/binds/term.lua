local term = require('custom.funcs.term')


vim.keymap.set('t', '<C-k>', vim.cmd.stopinsert,    { desc = 'to normal mode' })
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:qa!<CR>', { desc = 'quit' })
vim.keymap.set('t', '<A-c>', '<C-\\><C-n>:bd!<CR>', { desc = 'close buffer' })
vim.keymap.set('t', '<C-;>', '<C-\\><C-n>:',        { desc = 'open command mode' })
vim.keymap.set('n', '<leader>T', term.latest,       { desc = 'term last command' })
vim.keymap.set('n', '<leader>t', term.new,          { desc = 'terminal' })

