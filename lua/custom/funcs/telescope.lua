local actions_state = require 'telescope.actions.state'
local telescope = require 'telescope'
local git_root = require 'custom.funcs.git_root'
local builtin = require 'telescope.builtin'


local function find_dir(dir)
  builtin.find_files {
    cwd = dir,
    prompt_title = 'search in ' .. dir,
    find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'},
  }
end


local function grep_dir(dir)
  builtin.live_grep {
    prompt_title = 'grep in ' .. dir,
    search_dirs = { dir },
  }
end

local function grep_git_root()
  grep_dir(git_root.from_cwd())
end


local function find_git_root()
  find_dir(git_root.from_cwd())
end


local function enter()
  local selection = actions_state.get_selected_entry()
  telescope.extensions.file_browser.file_browser({
    path = selection.path,
    cwd = selection.path,
  })
end


local function custom_mappings(_, map)
  map({'i', 'n'}, '<CR>', enter, { desc = 'open in file browser' })
  return true
end


local function repo()
  telescope.extensions.repo.list{
    attach_mappings = custom_mappings,
  }
end


return {
  find_git_root = find_git_root,
  grep_git_root = grep_git_root,
  enter = enter,
  repo = repo,
}

