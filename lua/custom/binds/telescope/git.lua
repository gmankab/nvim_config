local builtin = require('telescope.builtin')
local git = require('custom.funcs.telescope.git')

vim.keymap.set('n', '<leader>fgs', builtin.git_files,   { desc = 'git staged files' })
vim.keymap.set('n', '<leader>fgr', git.find_root,       { desc = 'git root' })
vim.keymap.set('n', '<leader>fgg', git.grep_root,       { desc = 'git grep root' })

