local funcs_git_root = require 'custom.funcs.git_root'

local function open_term()
  local in_distrobox = vim.fn.getenv("CONTAINER_ID") ~= vim.NIL
  local shell = vim.fn.systemlist('basename $SHELL')[1]
  local git_root = funcs_git_root.from_cwd()
  vim.cmd('cd ' .. git_root)
  if in_distrobox then
    vim.cmd.terminal('distrobox-host-exec ' .. shell)
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
end


return {
  latest_command = latest_command,
  open_term = open_term,
  gitui = gitui,
}

