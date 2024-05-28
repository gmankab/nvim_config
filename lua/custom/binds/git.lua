local git = require('custom.funcs.git')

vim.keymap.set('n', '<leader>g', git.neogit_on_root, { desc = 'neogit' })

