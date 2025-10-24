-- Basic Neovim Configuration
-- Place this file at ~/.config/nvim/init.lua

-- General settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true     -- Highlight current line
vim.opt.wrap = false          -- Don't wrap lines
vim.opt.scrolloff = 8         -- Keep 8 lines visible when scrolling
vim.opt.sidescrolloff = 8     -- Keep 8 columns visible when scrolling

-- Indentation settings
vim.opt.tabstop = 4        -- Number of spaces that a tab counts for
vim.opt.softtabstop = 4    -- Number of spaces that a tab counts for while editing
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.autoindent = true  -- Copy indent from current line when starting new line
vim.opt.smartindent = true -- Smart autoindenting when starting new line

-- Search settings
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true  -- Case sensitive if search contains uppercase
vim.opt.hlsearch = true   -- Highlight search results
vim.opt.incsearch = true  -- Show search matches as you type

-- Visual settings
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.background = "dark"  -- Use dark background
vim.opt.signcolumn = "yes"   -- Always show sign column to avoid text shifting

-- File handling
vim.opt.backup = false      -- Don't create backup files
vim.opt.writebackup = false -- Don't create backup before overwriting
vim.opt.swapfile = false    -- Don't create swap files
vim.opt.undofile = true     -- Enable persistent undo

-- Split behavior
vim.opt.splitright = true -- Vertical splits go to the right
vim.opt.splitbelow = true -- Horizontal splits go below

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Basic key mappings
vim.g.mapleader = " " -- Set leader key to space

-- Clear search highlighting with Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize windows with arrow keys
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Auto-commands for file type specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "json", "html", "css", "yaml" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Disable netrw completely
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
