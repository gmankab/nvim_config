return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-lua/plenary.nvim',
    'cljoly/telescope-repo.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    local telescope = require 'telescope'
    pcall(telescope.load_extension, 'file_browser')
    require('custom.setup.telescope').config()
    pcall(telescope.load_extension, 'file_browser')
    pcall(telescope.load_extension, 'ui-select')
    pcall(telescope.load_extension, 'repo')
    pcall(telescope.load_extension, 'fzf')
  end,
}

