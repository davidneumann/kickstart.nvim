vim.g["grammarous#jar_url"] = 'https://www.languagetool.org/download/LanguageTool-5.9.zip'
vim.keymap.set('n', '<space>dg', ':GrammarousCheck --lang=en-us --comments-only<cr>',
	{ desc = 'Check [D]ocument [G]rammar' })

return {
	'rhysd/vim-grammarous'
}
