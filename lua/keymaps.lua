vim.keymap.set('n', '<space>sk', ':Telescope keymaps<cr>', { desc = '[S]earch [K]eymaps' })
vim.keymap.set({ 'n' }, '<C-_>', ':ToggleTerm direction=float <cr>', { desc = 'Toggle floating term' })
vim.keymap.set('n', '<Space>e', ':NvimTreeToggle<cr>', { desc = 'Toggle file tree' })

vim.keymap.set('n', '<space>cf', ':lua vim.lsp.buf.format()<cr>', { desc = 'Format code with LSP' })

vim.keymap.set('n', '<leader>gg', '<cmd>Git<cr>', { desc = '[G]it Fugitive' })
vim.keymap.set('n', '<leader>gP', '<cmd>Git push<cr>', { desc = '[G]it [P]ush' })

-- Disable macro recording
vim.keymap.set('n', 'q', '<Nop>')

vim.g.maplocalleader = ' '
local wkl = require('which-key')

vim.cmd('autocmd FileType,VimEnter * lua setKeybinds()')
function setKeybinds()
  local fileTy = vim.api.nvim_buf_get_option(0, "filetype")
  local opts = { prefix = '<localleader>', buffer = 0 }

  if fileTy == 'typescript' then
    wkl.register({
      ['co'] = { function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.organizeImports.ts" },
            diagnostics = {},
          },
        })
      end, 'Organize Imports' },
      ['cr'] = { function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.removeUnused.ts" },
            diagnostics = {},
          },
        })
      end, 'Remove Unused Imports' },
    }, opts)
  elseif fileTy == 'sh' then
    --Left here as an example for future me
    -- wkl.register({
    --   ['W'] = { ':w<CR>', 'test write' },
    --   ['Q'] = { ':q<CR>', 'test quit' },
    -- }, opts)
  end
end

-- Toggleterm keymaps
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  vim.keymap.set('t', '<C-_>', [[<Cmd>ToggleTerm direction=float<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
