local git = require('custom.funcs.git')

local function new()
  local in_distrobox = vim.fn.getenv("CONTAINER_ID") ~= vim.NIL
  local shell = vim.fn.systemlist('basename $SHELL')[1]
  local git_root = git.root()
  vim.cmd('cd ' .. git_root)
  if in_distrobox then
    vim.cmd.terminal('distrobox-host-exec ' .. shell)
  else
    vim.cmd.terminal()
  end
  vim.cmd.startinsert()
end

local function latest()
  new()
  vim.defer_fn(
    function()
      local feedkeys = vim.api.nvim_replace_termcodes('<Up><CR>', true, true, true)
      vim.api.nvim_feedkeys(feedkeys, 'm', false)
    end,
    200
  )
end

return {
  new = new,
  latest = latest,
}
