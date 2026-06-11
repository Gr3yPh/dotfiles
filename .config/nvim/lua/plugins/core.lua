return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "light" -- 确保 background 是 dark
      require("ayu").setup({
        mirage = false, -- 改为 true 使用 mirage 变体
        terminal = true,
      })
      vim.cmd("colorscheme ayu")
    end,
  },
}
