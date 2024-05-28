local other = require('custom.funcs.telescope.other')

vim.keymap.set('n', '<leader>e',  other.explore_current_dir, { desc = 'explorer' })

