vim.keymap.set('n', '<space>sk', ':Telescope keymaps<cr>', { desc = '[S]earch [K]eymaps' })
vim.keymap.set({ 'n' }, '<C-_>', ':ToggleTerm direction=float <cr>', { desc = 'Toggle floating term' })
vim.keymap.set('n', '<Space>e', ':NvimTreeToggle<cr>', { desc = 'Toggle file tree' })

vim.keymap.set('n', '<space>cf', ':lua vim.lsp.buf.format()<cr>', { desc = 'Format code with LSP' })

vim.keymap.set('n', '<leader>gg', '<cmd>Git<cr>', { desc = '[G]it Fugitive' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>', { desc = '[G]it [P]ush' })

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


vim.keymap.set('n', "]b", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer", silent = true })
vim.keymap.set('n', "L", "<cmd>BufferLineCycleNext<CR>", { desc = "Go to next buffer", silent = true })
vim.keymap.set('n', "[b", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to prev buffer", silent = true })
vim.keymap.set('n', "H", "<cmd>BufferLineCyclePrev<CR>", { desc = "Go to prev buffer", silent = true })
vim.keymap.set('n', "]B", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right", silent = true })
vim.keymap.set('n', "[B", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left", silent = true })
vim.keymap.set('n', '<leader>bl', '<cmd>BufferLineCloseRight<CR>', { desc = 'Delete buffers to the right' })
vim.keymap.set('n', '<leader>bh', '<cmd>BufferLineCloseLeft<CR>', { desc = 'Delete buffers to the left' })

vim.keymap.set('n', '<leader>q', '<cmd>qa<cr>', { desc = "Close session" })
vim.keymap.set('n', '<leader>ur', '<cmd>SessionRestore<cr>', { desc = "[R]estore session" })
vim.keymap.set('n', '<leader>uq', '<cmd>SessionSave<cr><cmd>qa<cr>', { desc = "[Q]uit session" })

vim.keymap.set('n', '<leader>ha', function() require("harpoon.mark").add_file() end, { desc = '[H]arpoon [A]dd File' })
vim.keymap.set('n', '<leader>hr', function() require("harpoon.mark").remove_file() end,
  { desc = '[H]arpoon [R]emove File' })
vim.keymap.set('n', '<leader>hs', '<cmd>Telescope harpoon marks<cr>', { desc = '[H]arpoon [S]search' })
vim.keymap.set('n', '<leader>sh', '<cmd>Telescope harpoon marks<cr>', { desc = '[S]search [H]arpoon' })
vim.keymap.set('n', '<leader>h1', function() require("harpoon.ui").nav_file(1) end, { desc = '[H]arpoon Goto File [1]' })
vim.keymap.set('n', '<leader>h2', function() require("harpoon.ui").nav_file(2) end, { desc = '[H]arpoon Goto File [2]' })
vim.keymap.set('n', '<leader>h3', function() require("harpoon.ui").nav_file(3) end, { desc = '[H]arpoon Goto File [3]' })
vim.keymap.set('n', '<leader>h4', function() require("harpoon.ui").nav_file(4) end, { desc = '[H]arpoon Goto File [4]' })

vim.keymap.set('n', '<leader>bd', ':bd<cr>', { desc = "[B]uffer [D]elete / Close" })
vim.keymap.set('n', '<leader>bs', ':w<cr>', { desc = "[B]uffer [S]ave" })
