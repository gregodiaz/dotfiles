TelescopeMapArgs = TelescopeMapArgs or {}

local tmap = function(key, f, options, buffer, mode)
	mode = mode or "n"

	local rhs = function()
		R("greg.telescope")[f](options or {})
	end

	local map_options = {
		remap = false,
		silent = true,
	}
	if buffer then
		map_options.buffer = buffer
	end

	vim.keymap.set(mode, key, rhs, map_options)
end

-- project files
tmap("<leader>pf", "project_files")
-- tmap("<leader>ps", "grep_string")
-- tmap("<leader>pw", "grep_word")
tmap("<leader><leader>/", "grep_string")
tmap("<leader>/", "grep_word")
tmap("<leader>pr", "file_browser_relative")
tmap("<leader>pb", "buffers")

-- git
-- rest in ../../plugins/fugitive.lua { t = git, d = diff, f = fetch, b = branches, c = commits, s = status }
tmap("<leader>gb", "branches")
tmap("<leader>gc", "git_commits")
tmap("<leader>gs", "git_status")

-- nvim
tmap("<leader>fnc", "find_nvim_config")
tmap("<leader>fnp", "find_nvim_plugin")

return tmap
