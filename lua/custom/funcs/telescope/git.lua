local custom_funcs_git = require('custom.funcs.git')
local builtin = require('telescope.builtin')
local find = require('custom.funcs.telescope.find')


local function grep_root()
  local root = custom_funcs_git.root()
  builtin.live_grep {
    search_dirs = { root },
  }
end


local function find_root()
  find.dir(custom_funcs_git.root())
end

return {
  grep_root = grep_root,
  find_root = find_root,
}

