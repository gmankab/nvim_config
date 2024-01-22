return {
  'max397574/better-escape.nvim',
  version = "*",
  config = function ()
    require("better_escape").setup {
      mapping = {"jk"},
      timeout = vim.o.timeoutlen,
      clear_empty_lines = false,
      keys = "<Esc>",
      -- example
      -- keys = function()
      --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
      -- end,
    }

    -- autosave file
    vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged"}, {
      pattern = "*",
      callback = function()
        vim.defer_fn(function()
          if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
            vim.cmd('silent update')
          end
        end, 10)
      end
    })
  end,
}

