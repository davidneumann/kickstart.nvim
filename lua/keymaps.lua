vim.keymap.set('n', '<space>sk', ':Telescope keymaps<cr>', { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sz', ':Telescope grep_string search=<cr>', { desc = '[S]earch Fu[Z]zy Code' })
vim.keymap.set({ 'n' }, '<C-_>', ':ToggleTerm direction=float <cr>', { desc = 'Toggle floating term' })
vim.keymap.set('n', '<Space>e', ':NvimTreeToggle<cr>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<Space>E', ':NvimTreeFindFile<cr>', { desc = 'Open File Tree & Focus File' })

vim.keymap.set('n', '<leader>gg', '<cmd>Git<cr>', { desc = '[G]it Fugitive' })
vim.keymap.set('n', '<leader>gp', '<cmd>Git push<cr>', { desc = '[G]it [P]ush' })

-- -- Disable macro recording
-- vim.keymap.set('n', 'q', '<Nop>')

vim.g.maplocalleader = ' '
local wkl = require('which-key')

vim.cmd('autocmd FileType,VimEnter,BufEnter * lua setKeybinds()')
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
      ['ce'] = {
        function()
          vim.opt.makeprg = "npm run --silent lint -- --format unix \\| grep ':'"
          vim.cmd("make")
          vim.cmd("botright copen")
        end, 'Run eslint Project Wide',
      },
      ['cm'] = {
        function()
          vim.opt.makeprg =
          "npx tsc --pretty false \\| grep \"./\" \\| sed -r 's/\\(([0-9]+),([0-9]+)\\)/:\\1:\\2/' \\| sed \"s@^@$PWD/@\""
          vim.cmd("make")
          vim.cmd("botright copen")
        end, 'Run tsc Project Wide',
      },
      ['cr'] = { function()
        vim.lsp.buf.code_action({
          apply = true,
          context = {
            only = { "source.removeUnused.ts" },
            diagnostics = {},
          },
        })
      end, 'Remove Unused Imports' },
      ['cc'] = { ':TSC<cr>', 'TSC Project Wide' },
    }, opts)
  elseif fileTy == 'sh' then
    --Left here as an example for future me
    -- wkl.register({
    --   ['W'] = { ':w<CR>', 'test write' },
    --   ['Q'] = { ':q<CR>', 'test quit' },
    -- }, opts)
  elseif fileTy == "" then
    wkl.register({
      ['f'] = {
        name = "[F]ile types",
        j = {
          function()
            vim.cmd("set ft=json")
            vim.cmd("%!jq '.'")
          end, 'Set [F]iletype [J]SON' }
      }
    }, opts)
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

-- vim.keymap.set('n', '<leader>q', '<cmd>qa<cr>', { desc = "Close session" })
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

vim.keymap.set('n', '<leader>qo', ':botright copen<cr>', { desc = '[Q]uickfix List [O]pen', silent = true })
vim.keymap.set('n', '<leader>qh', ':cclose<cr>', { desc = '[Q]uickfix List [H]ide', silent = true })
vim.keymap.set("n", "<leader>qc", ":call setqflist([], 'r')<cr>", { desc = "[Q]uickfix List [C]lear", silent = true })
vim.keymap.set('n', '<leader>l', ':lopen<cr>', { desc = 'Open Location List', silent = true })
vim.keymap.set('n', '<leader>L', ':lclose<cr>', { desc = 'Close Location List', silent = true })

vim.keymap.set("n", "<leader>sa", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
  { desc = "[S]earch ripgrep with [A]rgs" })

vim.keymap.set("n", "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end,
  { desc = "[T]est [O]utput" })
vim.keymap.set("n", "<leader>tO", function() require("neotest").output_panel.toggle() end,
  { desc = "[T]est Toggle [S-O]utput panel" })
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.open() end,
  { desc = "[T]est [S]ummary" })
vim.keymap.set("n", "<leader>tS", function() require("neotest").summary.toggle() end,
  { desc = "[T]est Toggle [S-S]ummary" })
vim.keymap.set("n", "<leader>tT", function() require("neotest").run.run(vim.loop.cwd()) end,
  { desc = "[T]est Run all [S-T]est files" })

vim.keymap.set('n', '<space>cf', ':lua vim.lsp.buf.format()<cr>', { desc = 'Format code with LSP' })
vim.keymap.set("v", "<leader>cf", vim.lsp.buf.format, { desc = "Format selected lines only?", silent = false })
vim.keymap.set("n", "<leader>cl", ":LspRestart<cr>", { desc = "LSP [C]ode action: restart [l]sp", silent = false })

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "<leader>Dt", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  { desc = "[T]rouble workspace diagnostics" })

vim.keymap.set("n", "<leader>uZ", "<cmd>ZenMode<cr>", { desc = "[U]I Toggle [Z]enMode" })
vim.keymap.set("n", "<leader>uT", "<cmd>Twilight<cr>", { desc = "[U]I Toggle [T]wilight" })
local focusToggle = false
vim.keymap.set("n", "<leader>uF", function()
  focusToggle = not focusToggle
  if focusToggle then
    require("zen-mode").open({
      window = {
        width = .85 -- width will be 85% of the editor width
      }
    })
    vim.cmd("TwilightEnable")
  else
    require("zen-mode").close({
      window = {
        width = .85 -- width will be 85% of the editor width
      }
    })
    vim.cmd("TwilightDisable")
  end
end, { desc = "[U]I Toggle [F]ocus with ZenMode & Twlight" })
