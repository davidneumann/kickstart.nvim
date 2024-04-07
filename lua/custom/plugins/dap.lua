local function store_breakpoints(clear)
	local HOME = os.getenv("HOME")
	-- if doesn't exist create it:
	if vim.fn.filereadable(HOME .. "/.cache/dap/breakpoints.json") == 0 then
		-- Create file
		os.execute("mkdir -p " .. HOME .. "/.cache/dap")
		os.execute("touch " .. HOME .. "/.cache/dap/breakpoints.json")
	end

	local load_bps_raw = io.open(HOME .. "/.cache/dap/breakpoints.json", "r"):read "*a"
	if load_bps_raw == "" then
		load_bps_raw = "{}"
	end

	local bps = vim.fn.json_decode(load_bps_raw)
	local breakpoints_by_buf = require("dap.breakpoints").get()
	if clear then
		for _, bufrn in ipairs(vim.api.nvim_list_bufs()) do
			local file_path = vim.api.nvim_buf_get_name(bufrn)
			if bps and bps[file_path] ~= nil then
				bps[file_path] = {}
			end
		end
	else
		local didChange = false
		for buf, buf_bps in pairs(breakpoints_by_buf) do
			bps[vim.api.nvim_buf_get_name(buf)] = buf_bps
			didChange = true
		end
		if not didChange then
			local current_buf_file_name = vim.api.nvim_buf_get_name(0)
			bps[current_buf_file_name] = nil
		end
	end
	local fp = io.open(HOME .. "/.cache/dap/breakpoints.json", "w")
	local final = vim.fn.json_encode(bps)
	if fp then
		fp:write(final)
		fp:close()
	end
end

local function load_breakpoints()
	local HOME = os.getenv("HOME")

	local fp = io.open(HOME .. "/.cache/dap/breakpoints.json", "r")
	if fp == nil then
		print "No breakpoints found."
		return
	end
	local content = fp:read "*a"
	local bps = vim.fn.json_decode(content)
	local loaded_buffers = {}
	local found = false
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local file_name = vim.api.nvim_buf_get_name(buf)
		if bps and bps[file_name] ~= nil and bps[file_name] ~= {} then
			found = true
		end
		loaded_buffers[file_name] = buf
	end
	if found == false then
		return
	end
	if not bps then return end
	for path, buf_bps in pairs(bps) do
		for _, bp in pairs(buf_bps) do
			local line = bp.line
			local opts = {
				condition = bp.condition,
				log_message = bp.logMessage,
				hit_condition = bp.hitCondition,
			}
			require("dap.breakpoints").set(opts, tonumber(loaded_buffers[path]), line)
		end
	end
end

vim.api.nvim_create_autocmd("BufRead", {
	callback = load_breakpoints
})

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
		"folke/neodev.nvim",
	},
	config = function()
		require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true }, })
		require("dapui").setup()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		require("dap-go").setup()
		require("nvim-dap-virtual-text").setup({
			clear_on_continue = true
		})

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'js-debug-adapater'
      },
    }

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}", --let both ports be the same for now...
			executable = {
				command = "node",
				-- -- 💀 Make sure to update this path to point to your installation
				args = { vim.fn.stdpath('data') .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
				-- command = "js-debug-adapter",
				-- args = { "${port}" },
			},
		}

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = 'pwa-node',
					request = 'launch',
					name = 'Launch Current File (pwa-node)',
					cwd = "${workspaceFolder}", -- vim.fn.getcwd(),
					args = { '${file}' },
					sourceMaps = true,
					protocol = 'inspector',
				},
				{
					type = 'pwa-node',
					request = 'launch',
					name = 'Launch Current File (Typescript)',
					cwd = "${workspaceFolder}",
					runtimeArgs = { '--loader=ts-node/esm' },
					program = "${file}",
					runtimeExecutable = 'node',
					-- args = { '${file}' },
					sourceMaps = true,
					protocol = 'inspector',
					outFiles = { "${workspaceFolder}/**/**/*", "!**/node_modules/**" },
					skipFiles = { '<node_internals>/**', 'node_modules/**' },
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
						"!**/node_modules/**",
					},
				},
			}
		end
	end,
	keys = {
		{ "<leader>dc", "<cmd>DapContinue<cr>", desc = "[D]iagnostics [C]ontinue" },
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
				store_breakpoints(false)
			end,
			desc = "[D]iagnostics [B]reakpoint Toggle"
		},
		{
			"<leader>dB",
			function()
				require("dap").toggle_breakpoint()
				store_breakpoints(true)
			end,
			desc = "[D]iagnostics Clear [B]reakpoints"
		},
		{
			"<leader>dk",
			function()
				require("dapui").eval()
			end,
			desc = "[D]iagnostics DAP eval"
		},
		{
			"<leader>dq",
			function()
				require("dapui").close()
				-- require("dap").disconnect()
				-- require("dap").close()
				require("dap").terminate()
			end,
			desc = "[D]iagnostics [Q]uit DAP"
		},
		{
			"<leader>dT",
			function()
				require("dapui").open({ reset = true })
			end,
			desc = "[D]iagnostics [T]oggle UI"
		},
	}
	,
}
