local builtin = require('telescope.builtin')


local function buffers()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'grep bufers',
  }
end


return {
  buffers = buffers,
}

