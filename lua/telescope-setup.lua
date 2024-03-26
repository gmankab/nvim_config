-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require "telescope.actions"
local builtin = require('telescope.builtin')
local neogit = require('neogit')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
      n = {
        ["q"] = actions.close,
        ["n"] = actions.cycle_history_next,
        ["N"] = actions.cycle_history_prev,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

local function search_in_dir(dir)
  require('telescope.builtin').find_files {
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
  local git_root =
  neogit.open({ cwd = find_git_root() })
end


vim.keymap.set('n', '<leader>gs', builtin.git_files, { desc = 'git root find [s]taget files' })
vim.keymap.set('n', '<leader>gg', live_grep_git_root, { desc = 'git root find by [g]rep' })
vim.keymap.set('n', '<leader>gn', neogit_on_git_root, { desc = 'neogit on git root' })
vim.keymap.set('n', '<leader>f/', telescope_live_grep_open_files, { desc = 'find by grep in open files' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'find [r]esume' })
vim.keymap.set('n', '<leader>ft', builtin.builtin, { desc = 'find [t]elescope select' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'find [b]uffers' })
vim.keymap.set('n', '<leader>fl', builtin.oldfiles, { desc = 'find [l]atest opened files' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'find [h]elp' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'find by [g]rep' })
vim.keymap.set('n', '<leader>fc', builtin.find_files, { desc = 'find in [c]urrent work dir' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'find current [w]ord' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'find [d]iagnostics' })
vim.keymap.set(
  'n', '<leader>gf', function()
    local git_root = find_git_root()
    search_in_dir(git_root)
  end, { desc = 'git root find all [f]iles' }
)
vim.keymap.set(
  'n', '<leader>fh', function()
    search_in_dir(vim.fn.expand('~'))
  end, { desc = 'find in [h]ome' }
)
vim.keymap.set(
  'n', '<leader>fp', function()
    search_in_dir(vim.fn.expand('~/proj'))
  end, { desc = 'find in ~/[p]roj' }
)
vim.keymap.set(
  'n', '<leader>fi', function()
    local dir = vim.fn.input('directory: ')
    search_in_dir(dir)
  end, { desc = 'find and [i]nput path to find in' }
)
vim.keymap.set(
  'n', '<leader>ff', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[f]uzzily search in current buffer' }
)

