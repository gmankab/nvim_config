return {
  "folke/tokyonight.nvim",
  dependencies = { 'rktjmp/lush.nvim' },
  enabled = true,
  lazy = false,
  priority = 1000,
  opts = {
    styles = { comments = { italic = false } },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-storm")
  end,
}
