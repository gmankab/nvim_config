-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local neogit = require('neogit')
local themes = require('telescope.themes')
local fb_utils = require('telescope._extensions.file_browser.utils')
local telescope = require('telescope')
local get_picker = require('telescope.actions.state').get_current_picker
local action_state = require('telescope.actions.state')
local file_browser = telescope.extensions.file_browser.file_browser
local fb_actions = telescope.extensions.file_browser.actions
local home = os.getenv('HOME')


local function paste(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local text = vim.fn.getreg('+'):gsub('\n', "")
  current_picker:set_prompt(text, false)
end

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

local function goto(path)
  return function(prompt_bufnr)
    local picker = get_picker(prompt_bufnr)
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

local function goto_git_root(prompt_bufnr)
  local picker = get_picker(prompt_bufnr)
  local git_root = get_git_root_from_path(picker.finder.path)
  local func = goto(git_root)
  func(prompt_bufnr)
end

local feedkeys_up = vim.api.nvim_replace_termcodes('8<up>', true, true, true)
local feedkeys_down = vim.api.nvim_replace_termcodes('8<down>', true, true, true)

local function move_coursor_up()
  vim.api.nvim_feedkeys(feedkeys_up, 'm', false)
end

local function move_coursor_down()
  vim.api.nvim_feedkeys(feedkeys_down, 'm', false)
end

telescope.setup {
  defaults = {
    initial_mode = 'normal',
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-v>'] = paste,
      },
      n = {
        [' '] = actions.toggle_selection,
        ['q'] = actions.close,
        ['n'] = actions.cycle_history_next,
        ['N'] = actions.cycle_history_prev,
        ['u'] = move_coursor_up,
        ['d'] = move_coursor_down,
        ['p'] = paste,
        ['P'] = goto(home .. '/proj'),
        ['C'] = goto(home .. '/.config'),
        ['H'] = fb_actions.goto_home_dir,
        ['D'] = fb_actions.remove,
        ['G'] = goto_git_root,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(telescope.load_extension, 'fzf')
telescope.load_extension 'file_browser'

local function grep_open_files()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

local function live_grep_git_root()
  local git_root = get_git_root()
  if git_root then
    builtin.live_grep {
      search_dirs = { git_root },
    }
  end
end

local function find_in_dir(dir)
  builtin.find_files {
    prompt_title = 'Search in ' .. dir,
    cwd = dir,
    find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'},
  }
end

function OpenTermInCurrentDir()
  local bufname = vim.api.nvim_buf_get_name(0)
  local dir = vim.fn.fnamemodify(bufname, ':p:h')
  vim.cmd('cd ' .. dir)
  vim.cmd('term')
end

local function neogit_on_git_root()
  neogit.open({ cwd = get_git_root() })
end

local function find_git_root_all_files()
  find_in_dir(get_git_root())
end

local function find_in_home()
  find_in_dir(vim.fn.expand('~'))
end

local function find_in_proj()
  find_in_dir(vim.fn.expand('~/proj'))
end

local function find_fuzzy_in_buffer()
  builtin.current_buffer_fuzzy_find(
    themes.get_dropdown {
      winblend = 10,
      previewer = false,
    }
  )
end

local function explore_current_dir()
  file_browser({
    path = vim.fn.expand('%:p:h'),
    grouped = true,
    display_stat = false,
  })
end


vim.keymap.set('n', '<leader>gs', builtin.git_files,       { desc = 'git root find [s]taget files' })
vim.keymap.set('n', '<leader>gg', live_grep_git_root,      { desc = 'git root find by [g]rep' })
vim.keymap.set('n', '<leader>gn', neogit_on_git_root,      { desc = 'neogit on git root' })
vim.keymap.set('n', '<leader>f/', grep_open_files,         { desc = 'find by grep in open files' })
vim.keymap.set('n', '<leader>fr', builtin.resume,          { desc = 'find [r]esume' })
vim.keymap.set('n', '<leader>ft', builtin.builtin,         { desc = 'find [t]elescope select' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,         { desc = 'find [b]uffers' })
vim.keymap.set('n', '<leader>fl', builtin.oldfiles,        { desc = 'find [l]atest opened files' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags,       { desc = 'find [h]elp' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,       { desc = 'find by [g]rep' })
vim.keymap.set('n', '<leader>fc', builtin.find_files,      { desc = 'find [c]urrent dir' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string,     { desc = 'find current [w]ord' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics,     { desc = 'find [d]iagnostics' })
vim.keymap.set('n', '<leader>gf', find_git_root_all_files, { desc = 'git root find all [f]iles' })
vim.keymap.set('n', '<leader>fh', find_in_home,            { desc = 'find in [h]ome' })
vim.keymap.set('n', '<leader>fp', find_in_proj,            { desc = 'find in ~/[p]roj' })
vim.keymap.set('n', '<leader>ff', find_fuzzy_in_buffer,    { desc = '[f]uzzily search in current buffer' })
vim.keymap.set('n', '<leader>e',  explore_current_dir,     { desc = '[e]xplorer' })

