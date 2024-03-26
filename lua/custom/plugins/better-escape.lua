return {
  'Sam-programs/better-escape.nvim',
  version = '*',
  config = function ()
    require('better_escape').setup {
      mapping = {'jk'},
      timeout = vim.o.timeoutlen,
      clear_empty_lines = false,
      keys = '<Esc>',
    }
    -- autosave file
    vim.api.nvim_create_autocmd({'InsertLeave'}, {
      pattern = '*',
      callback = function()
        vim.defer_fn(
          function()
            if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
              local current_view = vim.fn.winsaveview()
              vim.cmd([[keeppatterns %s/\s\+$//e]])
              vim.fn.winrestview(current_view)
              vim.cmd('silent update')
            end
          end, 10
        )
      end
    })
    vim.api.nvim_create_autocmd({'TextChanged'}, {
      pattern = '*',
      callback = function()
        vim.defer_fn(
          function()
            if vim.api.nvim_buf_get_option(0, 'buftype') == '' then
              vim.cmd('silent update')
            end
          end, 10
        )
      end
    })
  end,
}

