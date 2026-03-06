vim.lsp.config('ty', {
  cmd = { 'ty', 'server' },
  settings = {
    ty = {
      experimental = {
        rename = true,
        autoImport = true,
      },
    },
  },
})
vim.lsp.enable('ty')
vim.lsp.enable('ruff')
