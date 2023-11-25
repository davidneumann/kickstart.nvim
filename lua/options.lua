vim.opt.spell = true
vim.opt.spelllang = 'en_us'

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.syntax = 'on'
vim.opt.expandtab = true

vim.wo.relativenumber = true
vim.opt.scrolloff = 12

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = "pwsh.exe"
end
