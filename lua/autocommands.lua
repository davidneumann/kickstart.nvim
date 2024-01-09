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
