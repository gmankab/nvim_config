local funcs_git_root = require 'custom.funcs.git_root'

local function open_term()
  local in_container = vim.fn.getenv('container') ~= vim.NIL
  local is_hs_installed = vim.fn.executable('host-spawn') == 1
  local git_root = funcs_git_root.from_cwd()
  vim.cmd('cd ' .. git_root)
  if in_container and is_hs_installed then
    vim.cmd.terminal('host-spawn')
  else
    vim.cmd.terminal()
  end
  vim.cmd.startinsert()
end


local function latest_command()
  open_term()
  vim.defer_fn(
    function()
      local feedkeys = vim.api.nvim_replace_termcodes('<Up><CR>', true, true, true)
      vim.api.nvim_feedkeys(feedkeys, 'm', false)
    end,
    200
  )
end


local function gitui()
  local git_root = funcs_git_root.from_cwd()
  vim.cmd('cd ' .. git_root)
  vim.cmd.terminal('gitui')
  vim.cmd.startinsert()
end


return {
  latest_command = latest_command,
  open_term = open_term,
  gitui = gitui,
}

