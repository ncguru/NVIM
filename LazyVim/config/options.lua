-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.root_spec = { ".gitignore" }
local opt = vim.opt
opt.enc = "utf-8"
opt.fenc = "utf-8"
opt.fencs = { "utf-8", "sjis", "cp949", "ucs-bom", "latin1" }

-- Set the tabstop and shiftwidth options to 4
opt.tabstop = 4
opt.shiftwidth = 4
