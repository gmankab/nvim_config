local funcs_telescope = require 'custom.funcs.telescope'
local funcs_filebrowser = require 'custom.funcs.filebrowser'
local actions = require 'telescope.actions'
local telescope = require 'telescope'
local fb_actions = telescope.extensions.file_browser.actions
local home = os.getenv('HOME')


local function config()
  telescope.setup {
    defaults = {
      preview = {
        ls_short = true,
      },
      initial_mode = 'normal',
      hijack_netrw = true,
      mappings = {
        i = {
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,
          ['<C-v>'] = funcs_telescope.paste,
        },
        n = {
          ['<M-n>'] = actions.cycle_history_next,
          ['<M-e>'] = actions.cycle_history_prev,
          ['<C-n>'] = funcs_filebrowser.move_coursor(4),
          ['<C-e>'] = funcs_filebrowser.move_coursor(-4),
          ['n'] = actions.move_selection_next,
          ['e'] = actions.move_selection_previous,
          ['q'] = actions.close,
          [' '] = actions.toggle_selection,
          ['H'] = fb_actions.goto_home_dir,
          ['d'] = funcs_filebrowser.trash,
          ['C'] = funcs_filebrowser.goto(home .. '/.config'),
          ['P'] = funcs_filebrowser.goto(home .. '/proj'),
          ['G'] = funcs_filebrowser.goto_git_root,
          ['p'] = funcs_filebrowser.paste,
        },
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
      file_browser = {
        preview = {
          ls_short = true,
        }
      }
    }
  }
  pcall(telescope.load_extension, 'fzf')
  pcall(telescope.load_extension, 'ui-select')
  pcall(telescope.load_extension, 'file_browser')
end


return {
  config = config,
}

