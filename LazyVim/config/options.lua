-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.root_spec = { "", { "CapSeqTools", ".thisroot" }, "cwd" }
local opt = vim.opt
opt.enc = "utf-8"
opt.fenc = "utf-8"
opt.fencs = { "utf-8", "sjis", "cp949", "ucs-bom", "latin1" }

-- Set the tabstop and shiftwidth options to 4
opt.tabstop = 4
opt.shiftwidth = 4

vim.g.autoformat = false 
vim.diagnostic.disable()

local autocmd = vim.api.nvim_create_autocmd
-- 자동 파일 유형 설정
autocmd("BufRead", {
  pattern = { "*.xaml", "*.hta", "*.txt" },
  command = "setfiletype xml",
})
autocmd("BufNewFile", {
  pattern = { "*.xaml", "*.hta", "*.txt" },
  command = "setfiletype xml",
})

-- Check if PowerShell executable is available
local pwsh_executable = vim.fn.executable 'pwsh' == 1
local shell = pwsh_executable and 'pwsh' or 'powershell'

-- Set shell options
vim.opt.shell = shell
vim.opt.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

