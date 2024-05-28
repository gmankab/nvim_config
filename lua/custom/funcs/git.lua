local neogit = require('neogit')


local function root_from_path(path)
  local git_root = vim.fn.systemlist(
    'git -C ' .. vim.fn.escape(
      path,
      ' '
    ) .. ' rev-parse --show-toplevel'
  )[1]
  if vim.v.shell_error ~= 0 then
    print 'not a git repository'
    return path
  end
  return git_root
end


local function root()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    return root_from_path(
      vim.fn.getcwd()
    )
  else
    return root_from_path(
      vim.fn.fnamemodify(current_file, ':h')
    )
  end
end


local function neogit_on_root()
  neogit.open({ cwd = root() })
end


return {
  neogit_on_root = neogit_on_root,
  root_from_path = root_from_path,
  root = root,
}

