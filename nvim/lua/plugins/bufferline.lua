return {
	'akinsho/bufferline.nvim',
	version = '*',
	dependencies = "kyazdani42/nvim-web-devicons",
	opts = {
		options = {
			-- numbers = function(opts)
			-- 	return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
			-- end,
			right_mouse_command = "bdelete! %d",
			left_mouse_command = "buffer %d",
			indicator = {
				-- icon = '/',
				-- style = 'icon',
				style = 'underline',
			},
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = true,
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or level:match("warning") and " " or " "
				return " " .. icon .. count
			end,
			name_formatter = function(buf)
				if buf.name:find("index") or buf.name:find("style") then
				-- if buf.name == "index.tsx" or buf.name == "style.module.scss" then
					return buf.path:match("([^/]+)/[^/]*$")
				end

				-- return buf.name
				-- local tsfiles = { "index.*", "styles?.*" }
				-- local changeble = false

				-- for _, file in ipairs(tsfiles) do
				-- 	if changeble then
				-- 		break
				-- 	end
				-- 	changeble = buf.name:match(file)
				-- end
				--
				-- if changeble then
				-- 	return buf.path:gsub("/" .. buf.name, ""):match("[^/]+$") .. "/" .. buf.name
				-- end

				-- for _, file in ipairs(tsfiles) do
				-- 	if buf.name:match(file) then
				-- 		return buf.path:gsub("/" .. buf.name, ""):match("[^/]+$") .. "/" .. buf.name
				-- 	end
				-- end
				-- local nextjsfiles = { "page.*", "error.tsx", "layout.tsx", "default.tsx", "loading.tsx" }
				-- local nextjsfiles = { "page.*", "error.tsx", "layout.tsx", "default.tsx", "loading.tsx", "index.*", "styles?.*" }
				-- for _, file in ipairs(nextjsfiles) do
				-- 	if buf.name:match(file) then
				-- 		-- return buf.path:match("([^/]+)/[^/]+"):match("([^%.]+)") .. "/" .. buf.name
				-- 		return buf.path:match("([^/]+)/[^/]+"):match("([^%.]+)") .. "/" .. buf.name
				-- 	end
				-- end

				-- local nextjsfiles = { "page.*", "error.tsx", "layout.tsx", "default.tsx", "loading.tsx" }
				-- for _, file in ipairs(nextjsfiles) do
				-- 	if changeble then
				-- 		break
				-- 	end
				-- 	changeble = buf.name:match(file)
				-- end
				--
				-- if changeble then
				-- 	return buf.path:gsub("/" .. buf.name, ""):match("[^/]+$") .. "/" .. buf.name
				-- end

				-- return buf.name
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					text_align = "left",
					separator = true
				}
			},
			-- separator_style = "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
			separator_style = "slant",
			enforce_regular_tabs = true,
		}
	}
}
