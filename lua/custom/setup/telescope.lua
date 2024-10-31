local funcs_telescope = require 'custom.funcs.telescope'
local funcs_filebrowser = require 'custom.funcs.filebrowser'
local git_root = require 'custom.funcs.git_root'
local actions = require 'telescope.actions'
local telescope = require 'telescope'
local fb_actions = telescope.extensions.file_browser.actions
local home = os.getenv 'HOME'


local function config()
  local to_search = home .. '/files/proj'
  local repo_config = {
    file_ignore_patterns = { '%.local/', '%.cache/', '%.cargo/', '%.flatpak%-builder' },
    search_dirs = {to_search},
    cwd = to_search,
  }
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
          ['C'] = funcs_filebrowser.go_to(home .. '/.config'),
          ['P'] = funcs_filebrowser.go_to(home .. '/proj'),
          ['G'] = funcs_filebrowser.go_to(git_root.from_cwd()),
          ['p'] = funcs_filebrowser.paste,
        },
      },
    },
    extensions = {
      ['ui-select'] = {
        require('telescope.themes').get_dropdown(),
      },
      file_browser = {
        hidden=true,
        grouped = true,
        hijack_netrw = true,
        respect_gitignore = false,
        display_stat = { date = true, size = true },
        preview = { ls_short = true },
      },
      repo = {
        list = repo_config,
        cached_list = repo_config,
      }
    }
  }
end


return {
  config = config,
}

