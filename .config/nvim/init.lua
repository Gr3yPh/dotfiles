-- ==========================================
-- 1. 自动引导安装插件管理器 (lazy.nvim)
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- 2. 基础编辑器设置 (体验优化)
-- ==========================================
vim.opt.number = true         -- 显示绝对行号
vim.opt.relativenumber = true -- 显示相对行号 (Vim 盲打神器)
vim.opt.tabstop = 2          -- 1个Tab占4个空格
vim.opt.shiftwidth = 2        -- 自动缩进占4个空格
vim.opt.expandtab = true      -- 把Tab自动转换为空格
vim.opt.cursorline = true     -- 高亮当前行
vim.opt.termguicolors = true  -- 开启真彩色支持 (高亮和文件树需要)

-- ==========================================
-- 3. 插件安装配置 (只装你需要的东西)
-- ==========================================
require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 可选，提供好看的文件图标
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30, -- 宽度 30 个字符
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        -- 确保安装了你需要的语言高亮
        ensure_installed = { "c", "cpp", "java", "go", "html", "php", "javascript", "lua", "vim" },
        highlight = {
          enable = true, -- 开启高亮
        },
      })
    end,
  },
})

-- ==========================================
-- 4. 快捷键设置
-- ==========================================
-- 设置你的 Leader 键为空格 (Vim 圈的常识，方便按快捷键)
vim.g.mapleader = " "

-- 按 空格 + e 打开/关闭左侧文件树
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
