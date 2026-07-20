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
  -- 【文件管理器】：左侧文件树
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
      })
    end,
  },

  -- 【代码高亮】：Treesitter 语法解析
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = { "c", "cpp", "java", "go", "html", "php", "javascript", "lua", "vim" },
        highlight = { enable = true },
      })
    end,
  },

  -- 【符号自动闭合】
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- 【LSP 基础配置与自动补全】
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim-lsp" },
        }),
      }) -- <-- 检查这里：cmp.setup 的右括号和逗号

      -- ==========================================
      -- LSP 服务自动激活 (2026 最新原生标准写法)
      -- ==========================================
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 创建一个通用的底层配置
      local default_config = {
        capabilities = capabilities,
      }

      -- 当打开对应语言的文件时，自动启动 LSP
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "go", "gomod" },
        callback = function()
          vim.lsp.start({ name = "gopls", cmd = { "gopls" }, capabilities = capabilities })
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp" },
        callback = function()
          vim.lsp.start({ name = "clangd", cmd = { "clangd" }, capabilities = capabilities })
        end,
      })

    end, 
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        -- 1. 指定默认的聊天和行内补全策略都走 deepseek
        strategies = {
          chat = { adapter = "deepseek" },
          inline = { adapter = "deepseek" },
        },
        -- 2. 完美的自定义适配器：对接 DeepSeek
        adapters = {
          deepseek = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "DEEPSEEK_API_KEY", 
              },
              url = "https://api.deepseek.com",
              schema = {
                model = {
                  default = "deepseek-v4-flash",
                },
              },
            })
          end,
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

-- 光标停在报错/警告行，按 空格 + d 查看详细错误
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

-- 按 [d 或 ]d 可以在文件中的多个报错之间快速跳转
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })

-- ==========================================
-- CodeCompanion (DeepSeek) 侧边栏快捷键
-- ==========================================

-- 1. 按 空格 + cc 打开/关闭 AI 对话侧边栏
vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionActions<CR>", { desc = "AI Actions Menu" })

-- 2. 快速一键直接切出右侧聊天分屏 (Normal & Visual 模式通用)
vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle AI Chat" })
