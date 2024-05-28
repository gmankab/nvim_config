local telescope = require('telescope')
local file_browser = telescope.extensions.file_browser.file_browser

local function explore_current_dir()
  file_browser({
    path = vim.fn.expand('%:p:h'),
    grouped = true,
    display_stat = false,
    respect_gitignore = false,
  })
end


return {
  explore_current_dir = explore_current_dir,
}
