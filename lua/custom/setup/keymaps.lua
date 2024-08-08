local filebrowser = require 'custom.funcs.filebrowser'
local telescope = require 'custom.funcs.telescope'
local terminal = require 'custom.funcs.terminal'
local builtin = require 'telescope.builtin'
local which_key = require 'which-key'


-- which key
which_key.add {
  { '<leader>s', group = 'telescope search', icon = '' },
  { '<leader>l', group = 'lsp',              icon = '' },
  { '<leader>t', desc =  'terminal',         icon = '' },
  { '<leader>e', desc =  'file explorer',    icon = '󰥨' },
}
-- lsp
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist,  { desc = 'diagnostic quickfix' })
vim.keymap.set('n', '<leader>lf', vim.diagnostic.open_float,  { desc = 'float diagnostic' })
vim.keymap.set('n', '<leader>lh', vim.lsp.buf.signature_help, { desc = 'signature help' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action,    { desc = 'code action' })
vim.keymap.set('n', '<leader>ld', vim.lsp.buf.declaration,    { desc = 'declaration' })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename,         { desc = 'rename' })
-- telescope
vim.keymap.set('n', '<leader>ss', telescope.find_git_root, { desc = 'files' })
vim.keymap.set('n', '<leader>sg', telescope.grep_git_root, { desc = 'grep' })
vim.keymap.set('n', '<leader>sd', builtin.lsp_definitions, { desc = 'definitions' })
vim.keymap.set('n', '<leader>so', builtin.oldfiles,        { desc = 'oldfiles' })
vim.keymap.set('n', '<leader>sa', builtin.buffers,         { desc = 'buffers' })
vim.keymap.set('n', '<leader>st', builtin.builtin,         { desc = 'builtin' })
vim.keymap.set('n', '<leader>sr', builtin.resume,          { desc = 'resume' })
-- terminal
vim.keymap.set('n', '<leader>t', terminal.open_term,    { desc = 'terminal' })
vim.keymap.set('t', '<C-q>',     '<C-\\><C-n>:qa!<CR>', { desc = 'quit' })
vim.keymap.set('t', '<A-c>',     '<C-\\><C-n>:bd!<CR>', { desc = 'close buffer' })
vim.keymap.set('t', '<C-;>',     '<C-\\><C-n>:',        { desc = 'open command mode' })
vim.keymap.set('t', '<C-e>',     vim.cmd.stopinsert,    { desc = 'to normal mode' })
-- editor
vim.keymap.set('i', '<C-e>', vim.cmd.stopinsert, { desc = 'to normal mode' })
vim.keymap.set('v', '<C-e>', '<C-[>',            { desc = 'to normal mode' })
vim.keymap.set('i', '<C-v>', '<C-r>+',           { desc = 'paste' })
vim.keymap.set('n', '<C-v>', 'p',                { desc = 'paste' })
vim.keymap.set('n', '<C-q>', ':qa!<CR>',         { desc = 'quit' })
vim.keymap.set('n', '<A-c>', ':bd!<CR>',         { desc = 'close buffer' })
vim.keymap.set('c', '<C-v>', '<C-r>+',           { desc = 'paste' })
-- colemak
vim.keymap.set({ 'n', 'v' }, '<A-e>', 'e',       { desc = 'go to end of next word' })
vim.keymap.set({ 'n', 'v' }, '<A-i>', '<Right>', { desc = 'right' })
vim.keymap.set({ 'n', 'v' }, 'e',     '<Up>',    { desc = 'up' })
vim.keymap.set({ 'n', 'v' }, 'n',     '<Down>',  { desc = 'down' })
vim.keymap.set('i',          '<C-n>', '<CR>',    { desc = 'enter' })
vim.keymap.set('n',          '<A-n>', 'n',       { desc = 'next search result' })
-- cyrillic
vim.keymap.set('i', '<C-о>', '<C-j>', { desc = 'enter' })
vim.keymap.set('i', '<C-ц>', '<C-w>', { desc = 'del back word' })
vim.keymap.set('i', '<C-р>', '<C-h>', { desc = 'backspace' })
-- other
vim.keymap.set('n', '<leader>e', filebrowser.filebrowser_cwd, { desc = 'file explorer' })

