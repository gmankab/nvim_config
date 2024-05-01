-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local function terminal_outside_distrobox()
  local editor = vim.fn.systemlist('basename $SHELL')[1]
  vim.cmd.terminal('distrobox-host-exec ' .. editor)
  vim.cmd.startinsert()
end

local function terminal_latest()
  vim.cmd.terminal()
  vim.cmd.startinsert()
  vim.defer_fn(
    function()
      local feedkeys = vim.api.nvim_replace_termcodes('<Up><CR>', true, true, true)
      vim.api.nvim_feedkeys(feedkeys, 'm', false)
    end,
    200
  )
end

local function terminal_latest_proj()
  local editor = vim.fn.systemlist('basename $SHELL')[1]
  vim.cmd.terminal('distrobox-host-exec ' .. editor)
  vim.cmd.startinsert()
  vim.defer_fn(
    function()
      local feedkeys = vim.api.nvim_replace_termcodes('proj<Up><CR>', true, true, true)
      vim.api.nvim_feedkeys(feedkeys, 'm', false)
    end,
    200
  )
end


vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- cyrillic
vim.keymap.set('i', '<C-о>', '<C-j>', { desc = 'enter' })
vim.keymap.set('i', '<C-ц>', '<C-w>', { desc = 'del back word' })
vim.keymap.set('i', '<C-р>', '<C-h>', { desc = 'backspace' })
-- gmanka's custom
vim.keymap.set('v', '<C-k>', vim.cmd.stop,       { desc = 'to normal mode' })
vim.keymap.set('c', '<C-v>', '<C-r>+',           { desc = 'paste' })
vim.keymap.set('i', '<C-v>', '<C-r>+',           { desc = 'paste' })
vim.keymap.set('i', '<C-k>', vim.cmd.stopinsert, { desc = 'to normal mode' })
vim.keymap.set('n', '<C-v>', 'p',                { desc = 'paste' })
vim.keymap.set('n', '<C-q>', ':qa<CR>',          { desc = 'quit' })
vim.keymap.set('n', '<A-c>', ':bd<CR>',          { desc = 'close buffer' })
vim.keymap.set('n', '<C-;>', ':',                { desc = 'open command mode' })
-- terminal
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:qa!<CR>', { desc = 'quit' })
vim.keymap.set('t', '<A-c>', '<C-\\><C-n>:bd!<CR>', { desc = 'close buffer' })
vim.keymap.set('t', '<C-;>', '<C-\\><C-n>:',        { desc = 'open command mode' })
vim.keymap.set('t', '<C-k>', vim.cmd.stopinsert,    { desc = 'to normal mode' })

vim.keymap.set('n', '<leader>tt', ':term<CR>i',               { desc = 'open [t]erminal' })
vim.keymap.set('n', '<leader>tl', terminal_latest,            { desc = '[L]atest command in terminal' })
vim.keymap.set('n', '<leader>to', terminal_outside_distrobox, { desc = 'terminal [o]utside distrobox' })
vim.keymap.set('n', '<leader>tp', terminal_latest_proj,       { desc = 'terminal latest that contains "proj" outside distrobox' })

