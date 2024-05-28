local telescope = require('telescope')
local fb_utils = require('telescope._extensions.file_browser.utils')
local actions_state = require('telescope.actions.state')
local git = require('custom.funcs.git')
local file_browser = telescope.extensions.file_browser.file_browser


local function goto(path)
  return function(prompt_bufnr)
    local picker = actions_state.get_current_picker(prompt_bufnr)
    picker.finder.path = path
    fb_utils.redraw_border_title(picker)
    picker:refresh(
      picker.finder,
      {
        new_prefix = fb_utils.relative_path_prefix(picker.finder),
        multi = picker._multi,
      }
    )
  end
end


local function paste(prompt_bufnr)
  local picker = actions_state.get_current_picker(prompt_bufnr)
  local text = vim.fn.getreg('+'):gsub('\n', "")
  picker:set_prompt(text, false)
end


local function goto_git_root(prompt_bufnr)
  local picker = actions_state.get_current_picker(prompt_bufnr)
  local git_root = git.root_from_path(picker.finder.path)
  local func = goto(git_root)
  func(prompt_bufnr)
end


return {
  explore_current_dir = explore_current_dir,
  goto_git_root = goto_git_root,
  paste = paste,
  goto = goto,
}

