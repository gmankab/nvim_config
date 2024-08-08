local function from_path(path)
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


local function from_cwd()
  local current_file = vim.api.nvim_buf_get_name(0)
  if current_file == '' then
    return from_path(
      vim.fn.getcwd()
    )
  else
    return from_path(
      vim.fn.fnamemodify(current_file, ':h')
    )
  end
end


return {
  from_path = from_path,
  from_cwd = from_cwd,
}

