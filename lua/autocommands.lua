vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = '*.ejs',
  command = 'set filetype=embedded_template'
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.dot" },
  callback = function()
    vim.lsp.start({
      name = "dot",
      cmd = { "dot-language-server", "--stdio" }
    })
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.norg" },
  callback = function()
    vim.opt.cc = ""
  end,
})

-- Run gofmt on save
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'Red' })
    vim.cmd("match ExtraWhitespace /\\s\\+$/")
  end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'Red' })
    vim.cmd("match ExtraWhitespace /\\s\\+\\%#\\@<!$/")
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'Red' })
    vim.cmd("match ExtraWhitespace /\\s\\+$/")
  end,
})
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'Red' })
    vim.cmd("call clearmatches()")
  end,
})
