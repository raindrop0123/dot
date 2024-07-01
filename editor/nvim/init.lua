--@REF: https://github.com/ayamir/nvimdots
--@REF: https://astronvim.com/
--@REF: https://github.com/nvim-lua/kickstart.nvim/tree/master

-- Options --
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.backspace = "indent,eol,start"
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus,unnamed" --@See: https://www.reddit.com/r/neovim/comments/1aldvwq/clipboard_was_really_slowing_down_startup_found_a/
vim.opt.cmdheight = 0
vim.opt.cmdwinheight = 1
vim.opt.colorcolumn = "80"
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ruler = true
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0
vim.opt.undofile = false
vim.opt.wildmenu = true
vim.opt.writebackup = false
vim.opt.background = "dark"
vim.cmd.colorscheme "habamax"

-- autocmd --
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
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
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

-- mapping --
vim.g.mapleader = "\\"
vim.g.maplocalleader = ","
vim.api.nvim_set_keymap("n", "<leader>rc", "<Cmd>source $MYVIMRC<CR>", { desc = "Reload Config" })
vim.api.nvim_set_keymap("n", "<leader>rC", "<Cmd>e $MYVIMRC<CR>", { desc = "Edit Config" })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", {})

-- lazy.nvim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "tohtml",
        "logipat",
        "rrhelper",
        "spellfile",
        -- "matchit",
        -- "matchparen",
        "tutor",
        "man",
        "editorconfig",
        "health",
        "rplugin",
        "shada",
      },
    },
  },
})
