-- line numbers
vim.opt.nu = true

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- textwrap at 80 cols
vim.opt.tw = 80

-- fix WezTerm clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- replace tabs for spaces
vim.opt.expandtab = true

--
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
