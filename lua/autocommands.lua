vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = '*.ejs',
  command = 'set filetype=embedded_template'
})
