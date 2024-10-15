local telescope = require('telescope')
local actions_state = require('telescope.actions.state')
local actions_set = require('telescope.actions.set')
local fb_utils = require('telescope._extensions.file_browser.utils')
local fb_lsp = require "telescope._extensions.file_browser.lsp"
local async = require "plenary.async"
local Path = require "plenary.path"
local file_browser = telescope.extensions.file_browser.file_browser
local fb_actions = telescope.extensions.file_browser.actions


local function get_confirmation(opts, callback)
  local fb_config = require "telescope._extensions.file_browser.config"
  if fb_config.values.use_ui_input then
    opts.prompt = opts.prompt .. " [y/N]"
    vim.ui.input(opts, function(input)
      callback(input and input:lower() == "y")
    end)
  else
    async.run(function()
      return vim.fn.confirm(opts.prompt, table.concat({ "&Yes", "&No" }, "\n"), 2) == 1
    end, callback)
  end
end


--- trash file
---
---@note Performs a blocking synchronized file-system operation.
---@param prompt_bufnr number: The prompt bufnr
local function trash(prompt_bufnr)
  local current_picker = actions_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  local quiet = current_picker.finder.quiet
  local selections = fb_utils.get_selected_files(prompt_bufnr, true)
  if vim.tbl_isempty(selections) then
    fb_utils.notify("trash", { msg = "no selection to be trashed", level = "WARN", quiet = quiet })
    return
  end

  local files = vim.tbl_map(function(sel)
    return sel.filename:sub(#sel:parent().filename + 2)
  end, selections)

  for _, sel in ipairs(selections) do
    if sel:is_dir() then
      local abs = sel:absolute()
      local msg
      if finder.files and Path:new(finder.path):parent():absolute() == abs then
        msg = "parent folder cannot be trashed"
      end
      if not finder.files and Path:new(finder.cwd):absolute() == abs then
        msg = "current folder cannot be trashed"
      end
      if msg then
        fb_utils.notify("trash", { msg = msg .. " prematurely aborting", level = "WARN", quiet = quiet })
        return
      end
    end
  end

  local trashed = {}

  local message = "selections to be trashed: " .. table.concat(files, ", ")
  fb_utils.notify("trash", { msg = message, level = "INFO", quiet = quiet })
  -- TODO fix default vim.ui.input and nvim-notify 'selections to be trashed' message
  get_confirmation({ prompt = "trash selection? (" .. #files .. " items)" }, function(confirmed)
    vim.cmd [[ redraw ]] -- redraw to clear out vim.ui.prompt to avoid hit-enter prompt
    if confirmed then
      fb_lsp.will_delete_files(files)

      for _, p in ipairs(selections) do
        local is_dir = p:is_dir()
        local abs_path = p:absolute()
        vim.fn.system({'gio', 'trash', abs_path})
        -- clean up opened buffers
        if not is_dir then
          fb_utils.delete_buf(p:absolute())
        else
          fb_utils.delete_dir_buf(p:absolute())
        end
        table.insert(trashed, p.filename:sub(#p:parent().filename + 2))
      end

      fb_lsp.did_delete_files(files)
      fb_utils.notify(
        "trash",
        { msg = "trashed: " .. table.concat(trashed, ", "), level = "INFO", quiet = quiet }
      )
      current_picker:refresh(current_picker.finder)
    else
      fb_utils.notify("trash", { msg = "trashing selections aborted", level = "INFO", quiet = quiet })
    end
  end)
end


local function go_to(path)
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
  trash = trash,
  paste = paste,
  go_to = go_to,
}

