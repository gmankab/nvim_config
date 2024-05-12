local funcs = require('funcs')

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


local function terminal()
  local in_distrobox = vim.fn.getenv("CONTAINER_ID") ~= vim.NIL
  local shell = vim.fn.systemlist('basename $SHELL')[1]
  local git_root = funcs.get_git_root()
  vim.cmd('cd ' .. git_root)
  if in_distrobox then
    vim.cmd.terminal('distrobox-host-exec ' .. shell)
  else
    vim.cmd.terminal()
  end
  vim.cmd.startinsert()
end


local function terminal_latest()
  terminal()
  vim.defer_fn(
    function()
      local feedkeys = vim.api.nvim_replace_termcodes('<Up><CR>', true, true, true)
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

vim.keymap.set('n', '<leader>t', terminal,         { desc = '[t]erminal' })
vim.keymap.set('n', '<leader>T', terminal_latest,  { desc = '[T]erminal latest command' })


