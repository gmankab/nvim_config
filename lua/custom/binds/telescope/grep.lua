local builtin = require('telescope.builtin')
local grep = require('custom.funcs.telescope.grep')

vim.keymap.set('n', '<leader>fGb', grep.buffers,        { desc = 'grep buffers' })
vim.keymap.set('n', '<leader>fGc', builtin.live_grep,   { desc = 'grep current dir' })
vim.keymap.set('n', '<leader>fGs', builtin.grep_string, { desc = 'grep strings' })

