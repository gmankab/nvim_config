local function get_git_root_from_path(path)
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

local function get_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    return get_git_root_from_path(
      vim.fn.getcwd()
    )
  else
    return get_git_root_from_path(
      vim.fn.fnamemodify(current_file, ':h')
    )
  end
end

return {
  get_git_root_from_path = get_git_root_from_path,
  get_git_root = get_git_root,
}
