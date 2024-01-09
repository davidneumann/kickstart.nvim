vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = '*.ejs',
  command = 'set filetype=embedded_template'
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.norg" },
  callback = function()
    vim.opt.cc = ""
  end,
})
