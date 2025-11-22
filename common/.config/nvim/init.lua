-- 1) 基本UI
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.scrolloff = 4

-- 2) 検索
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- 3) インデント/タブ
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

-- 4) クリップボード
vim.opt.clipboard = "unnamedplus"

-- 5) ファイル操作
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- 6) 速度/品質
vim.opt.updatetime = 300
vim.opt.timeoutlen = 400
vim.opt.lazyredraw = true

-- 7) 便利
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 8) キーマップ
local map = vim.keymap.set
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
map("i", "jj", "<Esc>", opts)                      -- jjでEsc
map("n", "<Leader>w", "<Cmd>w<CR>", opts)          -- <Space>w で保存
map("n", "<Leader>q", "<Cmd>q<CR>", opts)          -- <Space>q で終了
map("n", "<Leader>h", "<Cmd>nohlsearch<CR>", opts) -- <Space>h で検索ハイライト解除

-- 9) 色
vim.cmd.colorscheme("default")

-- 10) 診断の見え方
vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- 11) 起動時メッセージを静かに
vim.opt.shortmess:append("I")

-- 12) 保存時に「末尾の空行をちょうど1行」に整える
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
    -- 末尾の連続空行を削除
    while #lines > 0 and lines[#lines] == "" do
      table.remove(lines, #lines)
    end
    -- 末尾に空行を1つ追加
    table.insert(lines, "")
    vim.api.nvim_buf_set_lines(0, 0, -1, true, lines)
  end,
})

-- 13) テーマ: Tokyo Night
-- lazy.nvim を自動導入
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end
  },
})
