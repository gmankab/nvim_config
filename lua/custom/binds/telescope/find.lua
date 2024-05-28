local builtin = require('telescope.builtin')
local find = require('custom.funcs.telescope.find')

vim.keymap.set('n', '<leader>fr', builtin.resume,      { desc = 'find resume' })
vim.keymap.set('n', '<leader>ft', builtin.builtin,     { desc = 'find telescope select' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,     { desc = 'find buffers' })
vim.keymap.set('n', '<leader>fl', builtin.oldfiles,    { desc = 'find latest opened files' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,   { desc = 'find help' })
vim.keymap.set('n', '<leader>fc', builtin.find_files,  { desc = 'find current dir' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'find diagnostics' })
vim.keymap.set('n', '<leader>ff', find.fuzzy_buffer,   { desc = 'find fuzzy buffer' })
vim.keymap.set('n', '<leader>fh', find.home,           { desc = 'find home' })
vim.keymap.set('n', '<leader>fp', find.proj,           { desc = 'find proj' })

