--- REFERENCE ---
-- https://github.com/boltlessengineer/NativeVim
-- https://github.com/HCY-ASLEEP/NVIM-Config
-- https://github.com/LazyVim/LazyVim
-- https://github.com/AstroNvim/AstroNvim
-- https://github.com/NvChad/NvChad
-- https://github.com/ayamir/nvimdots

--- GENERAL ---
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus,unnamed"
vim.opt.cmdheight = 0
vim.opt.cmdwinheight = 1
vim.opt.colorcolumn = "80"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.laststatus = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.showtabline = 0
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.whichwrap = "h,l,<,>,[,],~"
vim.opt.encoding = "utf-8"
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.wrap = false
vim.opt.sidescroll = 4
vim.opt.scrolloff = 2
vim.opt.sidescrolloff = 2
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wildmenu = true
vim.opt.background = "dark"
vim.cmd.colorscheme("retrobox")
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌵",
    }
  }
})

--- MAPPING ---
vim.g.mapleader = "\\"
vim.g.maplocalleader = " "
vim.api.nvim_set_keymap("n", "<leader>rc", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })
vim.api.nvim_set_keymap("n", "<leader>rC", "<cmd>edit $MYVIMRC<cr>", { desc = "Edit config" })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { desc = "Back to normal mode" })
vim.api.nvim_set_keymap("i", "<C-a>", "<Home>", {})
vim.api.nvim_set_keymap("i", "<C-e>", "<End>", {})
vim.api.nvim_set_keymap("i", "<C-d>", "<Del>", {})
vim.api.nvim_set_keymap("i", "<C-b>", "<Left>", {})
vim.api.nvim_set_keymap("i", "<C-f>", "<Right>", {})
vim.api.nvim_set_keymap("i", "<C-n>", "<Down>", {})
vim.api.nvim_set_keymap("i", "<C-p>", "<Up>", {})
vim.api.nvim_set_keymap("c", "<C-a>", "<Home>", {})
vim.api.nvim_set_keymap("c", "<C-e>", "<End>", {})
vim.api.nvim_set_keymap("c", "<C-d>", "<Del>", {})
vim.api.nvim_set_keymap("c", "<C-b>", "<Left>", {})
vim.api.nvim_set_keymap("c", "<C-f>", "<Right>", {})
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", {})
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", {})
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", {})
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", {})

--- AUTOCMD ---
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 1000 })
  end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_location", { clear = true }),
  callback = function()
    local exclude = { "gitcommit" }
    local buf = vim.api.nvim_get_current_buf()
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("disable_auto_comment", { clear = true }),
  callback = function()
    local current_buf = vim.api.nvim_get_current_buf()
    local formatoptions = vim.api.nvim_buf_get_option(current_buf, "formatoptions")
    formatoptions = formatoptions:gsub("[cro]", "")
    vim.api.nvim_buf_set_option(current_buf, "formatoptions", formatoptions)
  end,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("disable_syntax_when_large_file", { clear = true }),
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
    if file_size > 1048576 then
      vim.cmd("syntax clear")
    end
  end,
})

--- LAZY.NVIM ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
require("lazy").setup({
  spec = {
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins.extras.lang.clangd" },
    -- { "AstroNvim/AstroNvim", version = "^4", import = "astronvim.plugins" },
    { import = "plugin" },
  },
  ui = {
    size = {
      height = 0.88,
      width = 0.92,
    },
    border = "rounded",
    title = "Lazy Panel",
    title_pos = "center",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "editorconfig",
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "man",
        "matchit",
        "matchparen",
        "osc52",
        "tar",
        "tarPlugin",
        "rplugin",
        "rrhelper",
        "shada",
        "spellfile",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})
