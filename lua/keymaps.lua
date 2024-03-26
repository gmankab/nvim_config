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
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:qa!<CR>', { desc = 'quit' })
vim.keymap.set('t', '<A-c>', '<C-\\><C-n>:bd!<CR>', { desc = 'close buffer' })
vim.keymap.set('t', '<C-;>', '<C-\\><C-n>:', { desc = 'open command mode' })
vim.keymap.set('n', '<C-q>', ':qa<CR>', { desc = 'quit' })
vim.keymap.set('n', '<A-c>', ':bd<CR>', { desc = 'close buffer' })
vim.keymap.set('n', '<C-;>', ':', { desc = 'open command mode' })
vim.keymap.set('i', '<Esc>', '', { desc = 'disable esc' })
vim.keymap.set('i', '<C-k>', vim.cmd.stopinsert, { desc = 'to normal mode' })
vim.keymap.set('t', '<C-k>', vim.cmd.stopinsert, { desc = 'to normal mode' })
vim.keymap.set('v', '<C-k>', vim.cmd.stop, { desc = 'to normal mode' })
vim.keymap.set('n', '<leader>tt', ':term<CR>i', { desc = 'open [t]erminal' })
vim.keymap.set('n', '<leader>tl', ':term<CR>i<Up><CR>', { desc = '[l]atest command in terminal' })
vim.keymap.set('n', '<leader>n', vim.cmd.Ex, { desc = '[n]etrw files explorer' })
vim.keymap.set('n', '<leader>e', function()
  local buffers = vim.api.nvim_list_bufs()
  local neotree_buffer_found = false
  for _, buf in pairs(buffers) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if string.match(buf_name, "neo%-tree") then
      neotree_buffer_found = true
      break
    end
  end
  if neotree_buffer_found then
    vim.cmd(':Neotree close')
  else
    vim.cmd(':Neotree %:p:h<CR>')
  end
end, { silent = true, desc = 'neotree files [e]xplorer' })

