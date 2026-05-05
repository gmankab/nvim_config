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
vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemaStore = { enable = false, url = '' },
      schemas = {
        ['https://www.schemastore.org/any.json'] = { '**/*.yml', '**/*.yaml' },
      },
    },
  },
})
local function lsp_report()
  vim.wait(
    3000,
    function()
      return #vim.diagnostic.get(0) > 0
    end,
    100
  )
  vim.print(vim.diagnostic.get(0))
end

vim.api.nvim_create_user_command('LspReport', lsp_report, {})
for _, server in ipairs { 'ty', 'ruff', 'gh_actions_ls', 'yamlls', 'typos_lsp' } do
  vim.lsp.enable(server)
end
