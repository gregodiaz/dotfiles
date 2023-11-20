require("dap-vscode-js").setup({
	debugger_cmd = { "js-debug-adapter" },
	adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
	node_path = "/home/greg/.nvm/versions/node/v18.10.0/bin/node",                              -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	debugger_path = "/home/greg/.local/share/nvim/lazy/nvim-dap-vscode-js",                     -- Path to vscode-js-debug installation.
	log_file_path = "/home/greg/.local/share/nvim/lazy/nvim-dap-vscode-js/dap_vscode_js.log",   -- Path for file logging
	log_file_level = 1,                                                                         -- Logging level for output to file. Set to false to disable file logging.
	log_console_level = vim.log.levels.ERROR,                                                   -- Logging level for output to console. Set to false to disable console output.
})

require("dap").adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "6934",
	executable = {
		command = "/home/greg/.nvm/versions/node/v18.10.0/bin/node",
		-- 💀 Make sure to update this path to point to your installation
		args = { "/home/greg/.local/share/nvim/lazy/nvim-dap-vscode-js/js-debug/src/dapDebugServer.js", "6934" },
	}
}

for _, language in ipairs { "typescript", "javascript" } do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	}
end

for _, language in ipairs { "typescriptreact", "javascriptreact" } do
	require("dap").configurations[language] = {
		{
			type = "pwa-chrome",
			name = "Attach - Remote Debugging",
			request = "attach",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			port = 3232,
			webRoot = "${workspaceFolder}",
		},
		{
			type = "pwa-chrome",
			name = "Launch Chrome",
			request = "launch",
			url = "http://localhost:3000",
		},
	}
end
