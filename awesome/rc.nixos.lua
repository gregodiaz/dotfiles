-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- Awesome WM Widget
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local cpu_graph_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local net_widgets = require("net_widgets")
-- My widgets
local dual_sliders = require("myplugins.dual_slider")

local has_fdo, freedesktop = pcall(require, "freedesktop")

beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/main/theme.lua")

-- {{{ Notification Theme
naughty.config.spacing = 6

naughty.config.defaults.position = "top_left"
naughty.config.defaults.screen = 1
naughty.config.defaults.timeout = 7

beautiful.notification_icon_size = 69
beautiful.notification_margin = 20
beautiful.notification_border_width = 2
beautiful.notification_border_color = beautiful.indentline
beautiful.notification_shape = function(cr, width, height, _) gears.shape.rounded_rect(cr, width, height, 6) end

naughty.config.presets.critical = {
	bg = "#8a0808",
	fg = beautiful.fg_normal,
	timeout = 0,
}
naughty.config.presets.warn = {
	bg = beautiful.orange,
	fg = beautiful.bg_normal,
}
naughty.config.presets.normal = {
	bg = beautiful.black,
	fg = beautiful.fg_normal,
}
naughty.config.presets.low = {
	bg = beautiful.gray,
	fg = beautiful.fg_normal,
}
naughty.config.presets.ok = {
	bg = beautiful.green,
	fg = beautiful.bg_normal,
}
naughty.config.presets.info = {
	bg = beautiful.cyan,
	fg = beautiful.bg_normal,
}

-- naughty.notify({ title = "Awesome", text = "Awesome started", preset = naughty.config.presets.critical })
-- naughty.notify({ title = "Awesome", text = "Awesome started", preset = naughty.config.presets.warn })
-- naughty.notify({ title = "Awesome", text = "Awesome started", preset = naughty.config.presets.ok })
-- naughty.notify({ title = "Awesome", text = "Awesome started", preset = naughty.config.presets.info })
-- naughty.notify({ title = "Awesome", text = "Awesome started", preset = naughty.config.presets.normal })
-- naughty.notify({ title = "Awesome", text = "Awesome started", preset = naughty.config.presets.low })
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err)
		})
		in_error = false
	end)
end
-- }}}

-- This is used later as the default terminal and editor to run.
local terminal = "kitty"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Default superKey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
--	 I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local keySuper = "Mod4"
local keyControl = "Control"
local keyShift = "Shift"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.max,
	awful.layout.suit.magnifier,
	awful.layout.suit.floating,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
beautiful.menu_height = 25
beautiful.menu_width = 150
local myawesomemenu = {
	{ "Hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
	{ "Manual",      terminal .. " -e man awesome" },
	{ "Edit config", editor_cmd .. " " .. awesome.conffile },
	{ "Restart",     awesome.restart },
	{ "Quit",        function() awesome.quit() end },
	{ "Log out",     function() awesome.quit() end }
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

local mymainmenu = awful.menu({
	items = { { "Awesome", myawesomemenu },
		{ "Open terminal", terminal },
		{ "Browser",       "firefox" },
		{ "Files",         "thunar" },
	}
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local cw = calendar_widget({ theme = 'nord', placement = 'top_right', start_sunday = true, radius = 5 })

local mytextclock_hours = wibox.widget { format = '<b>%H:%Mhs</b>', widget = wibox.widget.textclock }
mytextclock_hours:connect_signal("button::press", function(_, _, _, button) if button == 1 then cw.toggle() end end)

local mytextclock_date = wibox.widget { format = '%a %d/%m', widget = wibox.widget.textclock }
mytextclock_date:connect_signal("button::press", function(_, _, _, button) if button == 1 then cw.toggle() end end)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal(
				"request::activate",
				"tasklist",
				{ raise = true }
			)
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end))

-- local function get_random_wallpaper_from_dir(type)
-- 	return gears.filesystem.get_random_file_from_dir(
-- 		"/home/greg/wallpapers/" .. type,
-- 		{ ".jpg", ".jpeg", ".png" },
-- 		true
-- 	)
-- end
-- beautiful.wallpaper = get_random_wallpaper_from_dir("dual")

local function scanDir(directory)
	local i, fileList, popen = 0, {}, io.popen
	for filename in popen([[find "]] .. directory .. [[" -type f]]):lines() do
		i = i + 1
		fileList[i] = filename
	end
	return fileList
end
local wallpaperList = scanDir("/home/greg/wallpapers/japan")

math.randomseed(os.time())

local function set_wallpaper(s)
	-- Wallpaper
	beautiful.wallpaper = wallpaperList[math.random(1, #wallpaperList)]
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.fit(wallpaperList[math.random(1, #wallpaperList)], s)
		-- gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
screen.connect_signal("request::wallpaper", set_wallpaper)

local set_tags = function(s)
	if screen.count() == 1 then
		awful.tag({ "dev", "local", "www", "mus", "wpp", "chat" }, s, awful.layout.layouts[1])
	else
		if (s.index == 1) then
			awful.tag({ "local", "www", "wpp", "chat" }, s, awful.layout.layouts[1])
		else
			awful.tag({ "dev", "www", "mus", }, s, awful.layout.layouts[1])
		end
	end
end

screen.connect_signal("request::tags", set_tags)

local function set_background_widget(wgt, bg, fg, inner_margin, margin)
	bg = bg or beautiful.bg_normal
	fg = fg or beautiful.fg_normal
	inner_margin = inner_margin or 0
	margin = margin or 0

	local wgt_with_inner_margin = wibox.container.margin(wgt, inner_margin, inner_margin)
	local wgt_with_margin = wibox.container.margin(wgt_with_inner_margin, margin, margin)

	local wgt_with_bg = wibox.widget {
		wgt_with_margin,
		bg = bg,
		fg = fg,
		shape = gears.shape.rectangle,
		widget = wibox.container.background
	}

	return wgt_with_bg
end

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	-- set_wallpaper(s)
	s:emit_signal("request::wallpaper")

	-- Each screen has its own tag table.
	s:emit_signal("request::tags")

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen          = s,
		filter          = awful.widget.taglist.filter.all,
		style           = { shape = gears.shape.rectangle },
		layout          = {
			spacing_widget = {
				color  = beautiful.blue,
				shape  = gears.shape.rectangle,
				widget = wibox.widget.separator,
			},
			layout         = wibox.layout.fixed.horizontal
		},
		widget_template = {
			{
				{
					{
						{
							{
								id     = "index_role",
								widget = wibox.widget.textbox,
							},
							margins = 1,
							widget  = wibox.container.margin,
						},
						bg     = beautiful.bg_normal,
						fg     = beautiful.bg_focus,
						shape  = function(cr, width, height)
							gears.shape.transform(gears.shape.circle):translate(2.5, 2.5):scale(.8, .8)(cr, width, height)
						end,
						widget = wibox.container.background,
					},
					{
						id     = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left   = 5,
				right  = 10,
				widget = wibox.container.margin
			},
			id              = "background_role",
			widget          = wibox.container.background,
			create_callback = function(self, c3, index, objects)
				self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
			end,
		},
		buttons         = taglist_buttons
	}

	-- Create the wibox
	s.wibar = awful.wibox({
		position = "top",
		screen = s,
		height = 20,
		-- bg = "#282c34cc",
		-- border_width = beautiful.useless_gap,
		-- border_color = "#0000"
	})

	local dual_slider = dual_sliders.create_dual_slider_for_screen(s.index)

	local right_widget_width = 70
	local right_wibar_widget_left_screen = function()
		return {
			align = "center",
			valign = "center",
			forced_width = right_widget_width,
			widget = wibox.widget.textbox
		}
	end

	local mem_widget = right_wibar_widget_left_screen()
	vicious.register(mem_widget, vicious.widgets.mem, "RAM $1%", 5)

	-- Crear un widget para mostrar el uso del CPU
	local cpu_widget = right_wibar_widget_left_screen()
	vicious.register(cpu_widget, vicious.widgets.cpu, "CPU $1%", 5)

	local net_internet = net_widgets.internet({ indent = 0, timeout = 5 })
	local net_wireless = wibox.widget.textbox()
	vicious.register(net_wireless, vicious.widgets.wifi, function(widget, args)
		if args["{ssid}"] == "N/A" then
			return "  "
		end
		return string.format("%s", args["{ssid}  "])
	end, 13, "wlo1")
	local net_wired = net_widgets.indicator({ interfaces = { "enp0s20f0u3u2" }, timeout = 5, popup_position = "top_right" })

	-- Add widgets to the wibar
	if s.index == 1 or screen.count() == 1 then
		s.wibar:setup {
			layout = wibox.layout.align.horizontal,
			{
				-- Left widgets
				layout = wibox.layout.fixed.horizontal,
				s.mytaglist,
				s.mypromptbox,
			},
			-- Middle widget
			nil,
			{
				-- Right widgets
				layout = wibox.layout.fixed.horizontal,
				spacing = beautiful.useless_gap,
				separator = beautiful.separator_thikness,
				dual_slider.gamma,
				dual_slider.brightness,
				net_wireless,
				net_wired,
				net_internet,
				volume_widget {
					mixer_cmd = terminal .. " -e alsamixer",
					widget_type = "vertical_bar",
					with_icon = true,
					device = "default",
				},
				battery_widget {
					font = beautiful.font,
					show_current_level = true,
					margin_right = beautiful.useless_gap * 2,
				},
				set_background_widget(mytextclock_date, beautiful.indentline, beautiful.green, 2, beautiful.useless_gap),
				set_background_widget(mytextclock_hours, beautiful.green, beautiful.indentline, 2, beautiful.useless_gap),
				s.mylayoutbox,
			},
		}
	else
		s.wibar:setup {
			layout = wibox.layout.align.horizontal,
			{
				-- Left widgets
				layout = wibox.layout.fixed.horizontal,
				s.mytaglist,
				s.mypromptbox,
			},
			-- Middle widget
			nil,
			{
				-- Right widgets
				layout = wibox.layout.fixed.horizontal,
				separator = beautiful.separator_thikness,
				spacing = beautiful.useless_gap,
				dual_slider.gamma,
				dual_slider.brightness,
				cpu_graph_widget({
					step_spacing = 0,
					color = beautiful.gray,
					enable_kill_button = true,
				}),
				mem_widget,
				cpu_widget,
				set_background_widget(mytextclock_date, beautiful.indentline, beautiful.green, 2, beautiful.useless_gap),
				set_background_widget(mytextclock_hours, beautiful.green, beautiful.indentline, 2, beautiful.useless_gap),
				s.mylayoutbox,
			},
		}
	end
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
	awful.button({}, 3, function() mymainmenu:toggle() end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

local function add_tag()
	awful.prompt.run {
		prompt       = "New tags name: ",
		textbox      = awful.screen.focused().mypromptbox.widget,
		exe_callback = function(new_name)
			if not new_name or #new_name == 0 then return end

			local t = awful.screen.focused().selected_tag
			if t then
				awful.tag.add(new_name, {
					screen = awful.screen.focused(),
					layout = awful.layout.suit.floating
				}):view_only()
			end
		end
	}
end

local function delete_tag()
	local t = awful.screen.focused().selected_tag
	if not t then return end
	t:delete()
end

local function move_to_new_tag()
	local c = client.focus
	if not c then return end

	local t = awful.tag.add(c.class, { screen = c.screen })
	c:tags({ t })
	t:view_only()
end

-- {{{ Key bindings
local globalkeys = gears.table.join(
	awful.key({ keySuper, keyControl }, "w", function()
			awful.screen.connect_for_each_screen(function(s)
				s:emit_signal("request::wallpaper")
			end)
		end,
		{ description = "change wallpapers", group = "custom" }),

	awful.key({ keySuper, keyControl }, "a", add_tag,
		{ description = "add a tag", group = "tag" }),
	awful.key({ keySuper, keyControl }, "d", delete_tag,
		{ description = "delete the current tag", group = "tag" }),
	awful.key({ keySuper, keyControl }, "m", move_to_new_tag,
		{ description = "move the current window to a new tag", group = "tag" }),
	awful.key({ keySuper, }, ";", hotkeys_popup.show_help,
		{ description = "show help", group = "awesome" }),

	awful.key({}, "XF86AudioRaiseVolume", function()
		-- awful.util.spawn("amixer sset Master 5%+")
		volume_widget:inc(5)
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		-- awful.util.spawn("amixer sset Master 5%-")
		volume_widget:dec(5)
	end),
	awful.key({}, "XF86AudioMute", function()
		-- awful.util.spawn("amixer sset Master toggle")
		volume_widget:toggle()
	end),

	awful.key({ keySuper, }, "w", function() mymainmenu:show() end,
		{ description = "show main menu", group = "awesome" }),

	awful.key({ keySuper, }, "u", awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }),
	awful.key({ keySuper, }, "t", function() awful.spawn(terminal) end,
		{ description = "open a terminal", group = "launcher" }),

	awful.key({ keySuper, keyControl }, "r", awesome.restart,
		{ description = "reload awesome", group = "awesome" }),

	awful.key({ keySuper, keyShift }, "q", awesome.quit,
		{ description = "quit awesome", group = "awesome" }),
	awful.key({ keySuper, }, "space", function() awful.layout.inc(1) end,
		{ description = "select next", group = "layout" }),
	awful.key({ keySuper, keyShift }, "space", function() awful.layout.inc(-1) end,
		{ description = "select previous", group = "layout" }),


	awful.key({ keySuper, keyControl }, "n",
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal(
					"request::activate", "key.unminimize", { raise = true }
				)
			end
		end,
		{ description = "restore minimized", group = "client" }),


	awful.key({ keySuper }, "p", function() menubar.show() end,
		{ description = "show the menubar", group = "launcher" }),

	awful.key({ keySuper }, "j", function() awful.util.spawn("thunar") end,
		{ description = "file manager", group = "applications" }),
	awful.key({ keySuper }, "g", function()
			awful.spawn("xfce4-appfinder",
				{
					floating  = true,
					tag       = mouse.screen.selected_tag,
					placement = awful.placement.centered,
					width     = 600,
					height    = 400,
				})
		end,
		{ description = "app finder", group = "applications" }),
	awful.key({ keySuper }, "b", function() awful.util.spawn("firefox") end,
		{ description = "firefox", group = "applications" }),

	awful.key({ keySuper, }, "e", awful.tag.viewprev,
		{ description = "view previous", group = "tag" }),

	awful.key({ keySuper, }, "r", awful.tag.viewnext,
		{ description = "view next", group = "tag" }),

	awful.key({ keySuper, }, "f",
		function()
			awful.client.focus.byidx(1)
		end,
		{ description = "focus next by index", group = "client" }
	),
	awful.key({ keySuper, }, "d",
		function()
			awful.client.focus.byidx(-1)
		end,
		{ description = "focus previous by index", group = "client" }
	),

	awful.key({ keySuper, }, "s", function() awful.client.swap.byidx(1) end,
		{ description = "swap with next client by index", group = "client" }),
	awful.key({ keySuper, }, "a", function() awful.client.swap.byidx(-1) end,
		{ description = "swap with previous client by index", group = "client" }),
	awful.key({ keySuper }, "v", function() awful.screen.focus_relative(1) end,
		{ description = "focus the next screen", group = "screen" }),
	awful.key({ keySuper }, "c", function() awful.screen.focus_relative(-1) end,
		{ description = "focus the previous screen", group = "screen" }),
	awful.key({ keySuper, }, "x", function() awful.tag.incmwfact(0.05) end,
		{ description = "increase master width factor", group = "layout" }),
	awful.key({ keySuper, }, "z", function() awful.tag.incmwfact(-0.05) end,
		{ description = "decrease master width factor", group = "layout" })
)

local clientkeys = gears.table.join(
	awful.key({ keySuper, keyControl }, "q", function(c) c:kill() end,
		{ description = "close", group = "client" }),
	awful.key({ keySuper, keyControl }, "space", awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }),
	awful.key({ keySuper, keyControl }, "Return", function(c) c:swap(awful.client.getmaster()) end,
		{ description = "move to master", group = "client" }),
	awful.key({ keySuper, }, "o", function(c) c:move_to_screen() end,
		{ description = "move to screen", group = "client" }),

	awful.key({ keySuper, }, "n",
		function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end,
		{ description = "minimize", group = "client" }),

	awful.key({ keySuper, }, "m",
		function(c)
			c.maximized = not c.maximized
			c:raise()
		end,
		{ description = "(un)maximize", group = "client" }),

	awful.key({ keySuper, keyControl }, "m",
		function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end,
		{ description = "(un)maximize vertically", group = "client" }),

	awful.key({ keySuper, keyShift }, "m",
		function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end,
		{ description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ keySuper }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{ description = "view tag #" .. i, group = "tag" }),
		-- Move client to tag.
		awful.key({ keySuper, keyControl }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{ description = "move focused client to tag #" .. i, group = "tag" }),
		-- Toggle tag on focused client.
		awful.key({ keySuper, keyControl, keyShift }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{ description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ keySuper }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ keySuper }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	},

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer" },

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up",    -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = { floating = true, placement = awful.placement.centered }
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" }
		},
		properties = { titlebars_enabled = false }
	},

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
	{
		rule = { class = "Spotify" },
		properties = { screen = 2 or 1, tag = "mus", maximized = true }
	},

	{
		rule = { class = "Whatsapp" },
		properties = { screen = 1, tag = "wpp", maximized = true }
	},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup
			and not c.size_hints.user_position
			and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c):setup {
		{
			-- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{
			-- Middle
			{
				-- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{
			-- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

awesome.connect_signal("startup", function()
	awful.spawn.with_shell("autorandr main")
	awful.spawn.with_shell("picom --config ~/.config/picom/picom.config")

	awful.spawn("whatsapp-for-linux")
	awful.spawn("spotify")
	-- awful.spawn.once("firefox --restore", { screen = 2, tag = "www" })
	-- awful.spawn.once("google-chrome http://localhost:3232", { screen = 2, tag = "local" })
	-- awful.spawn.once("firefox https://chat.openai.com/", { screen = 2, tag = "chat" })
end)
