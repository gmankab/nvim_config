local actions = require('telescope.actions')
local telescope = require('telescope')
local fb_actions = telescope.extensions.file_browser.actions
local home = os.getenv('HOME')
local window = require('custom.funcs.telescope.window')


telescope.load_extension 'file_browser'
telescope.setup {
  defaults = {
    initial_mode = 'normal',
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-v>'] = window.paste,
      },
      n = {
        [' '] = actions.toggle_selection,
        ['n'] = actions.cycle_history_next,
        ['N'] = actions.cycle_history_prev,
        ['C'] = window.goto(home .. '/.config'),
        ['P'] = window.goto(home .. '/proj'),
        ['G'] = window.goto_git_root,
        ['H'] = fb_actions.goto_home_dir,
        ['D'] = fb_actions.remove,
        ['q'] = actions.close,
        ['p'] = window.paste,
      },
    },
  },
}

