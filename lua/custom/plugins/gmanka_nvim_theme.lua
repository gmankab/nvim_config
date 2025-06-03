return {
  'gmankab/gmanka_nvim_theme',
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    vim.cmd.colorscheme('gmanka')
  end,
}

