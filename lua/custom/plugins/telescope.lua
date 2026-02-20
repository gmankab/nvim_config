vim.pack.add {
  'https://github.com/nvim-telescope/telescope-file-browser.nvim',
  'https://github.com/cljoly/telescope-repo.nvim',
}

local telescope = require 'telescope'

require('custom.setup.telescope').config()

pcall(telescope.load_extension, 'file_browser')
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'repo')
pcall(telescope.load_extension, 'fzf')
