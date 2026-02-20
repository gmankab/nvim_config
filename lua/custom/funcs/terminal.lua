local funcs_git_root = require 'custom.funcs.git_root'

local function open_term()
  local in_container = vim.fn.getenv('container') ~= vim.NIL
  local is_hs_installed = vim.fn.executable('host-spawn') == 1
  vim.cmd('cd ' .. funcs_git_root.get_cwd())
  if in_container and is_hs_installed then
    vim.cmd.terminal('host-spawn')
  else
    vim.cmd.terminal()
  end
  vim.cmd.startinsert()
end

return {
  open_term = open_term,
}
