local builtin = require('telescope.builtin')
local themes = require('telescope.themes')


local function dir(dir_to_open)
  builtin.find_files {
    prompt_title = 'search in ' .. dir_to_open,
    cwd = dir_to_open,
    find_command = {'rg', '--files', '--hidden', '--glob', '!.git/*'},
  }
end


local function fuzzy_buffer()
  builtin.current_buffer_fuzzy_find(
    themes.get_dropdown {
      winblend = 10,
      previewer = false,
    }
  )
end


local function home()
  dir(vim.fn.expand('~'))
end


local function proj()
  dir(vim.fn.expand('~/proj'))
end

return {
  fuzzy_buffer = fuzzy_buffer,
  home = home,
  proj = proj,
  dir = dir,
}

