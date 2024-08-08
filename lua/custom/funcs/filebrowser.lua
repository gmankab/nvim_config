local actions_state = require('telescope.actions.state')
local actions_set = require('telescope.actions.set')
local fb_utils = require('telescope._extensions.file_browser.utils')
local telescope = require('telescope')
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


local function move_coursor(lines)
  return function(prompt_bufnr)
    actions_set.shift_selection(prompt_bufnr, lines)
  end
end


local function paste(prompt_bufnr)
  local picker = actions_state.get_current_picker(prompt_bufnr)
  local text = vim.fn.getreg('+'):gsub('\n', "")
  picker:set_prompt(text, false)
end


local function filebrowser_cwd()
  file_browser({
    path = vim.fn.expand('%:p:h'),
    grouped = true,
    display_stat = false,
    respect_gitignore = false,
    preview = { ls_short = true }
  })
end


return {
  filebrowser_cwd = filebrowser_cwd,
  move_coursor = move_coursor,
  paste = paste,
  goto = goto,
}

