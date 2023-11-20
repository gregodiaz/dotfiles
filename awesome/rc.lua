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
local ruled = require("ruled")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
-- Awesome WM Widget
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local net_widgets = require("net_widgets")
-- My widgets
local dual_sliders = require("myplugins.dual_slider")
-- when client with a matching name is opened:

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)

beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/main/theme.lua")

naughty.config.defaults = {
	icon_size = 69,
	screen = 1,
	position = "top_left",
	timeout = 6,
	hover_timeout = 6,
	margin = 20,
	shape = function(cr, width, height, _)
		gears.shape.rounded_rect(cr, width, height, 6)
	end,
	border_width = 2,
	border_color = beautiful.indentline,
}

naughty.config.spacing = 6

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

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/main/theme.lua")
-- beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- This is used later as the default terminal and editor to run.
-- terminal = "xterm"
local terminal = "x-terminal-emulator"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Default superKey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
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

local mymainmenu = awful.menu({
	items = { { "Awesome", myawesomemenu },
		{ "Open terminal", terminal },
		{ "Browser",       "firefox" },
		{ "Files",         "nautilus" },
	}
})

local mylauncher = awful.widget.launcher({
	image = beautiful.layout_tile,
	menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
local mytextclock_hours = wibox.widget {
	-- format = '<span foreground="' .. beautiful.indentline .. '"><b>%H:%M' .. 'hs</b></span>',
	format = '<b>%H:%M' .. 'hs</b>',
	widget = wibox.widget.textclock
}
local mytextclock_date = wibox.widget {
	-- format = '<span foreground="' .. beautiful.green .. '">%a %d/%m</span>',
	format = '%a %d/%m',
	widget = wibox.widget.textclock
}

-- default
local cw = calendar_widget({
	theme = 'nord',
	placement = 'top_right',
	start_sunday = true,
	radius = 5,

})
-- or customized
mytextclock_hours:connect_signal("button::press",
	function(_, _, _, button)
		if button == 1 then cw.toggle() end
	end)
mytextclock_date:connect_signal("button::press",
	function(_, _, _, button)
		if button == 1 then cw.toggle() end
	end)

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

-- {{{ Ramdom wallpaper
local function get_random_wallpaper_from_dir(type)
	return gears.filesystem.get_random_file_from_dir(
		"/home/greg/wallpapers/" .. type,
		{ ".jpg", ".jpeg", ".png" },
		true
	)
end

-- for s in screen do
-- 	local dpi = s.index * 100
--
-- 	awful.wallpaper {
-- 		screen = s,
-- 	}
-- end

beautiful.wallpaper = get_random_wallpaper_from_dir("japan")

local function set_wallpaper(s)
	local dir = "japan"
	beautiful.wallpaper = get_random_wallpaper_from_dir(dir)

	if dir ~= "dual" then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.fit(beautiful.wallpaper, s)
	else
		awful.wallpaper {
			screens = {
				screen[1],
				screen[2],
			},
			dpi     = s.dpi,
			widget  = wibox.widget {
				{
					image                 = beautiful.wallpaper,
					resize                = true,
					horizontal_fit_policy = "fit",
					vertical_fit_policy   = "fit",
					widget                = wibox.widget.imagebox
				},
				valign = "center",
				halign = "center",
				widget = wibox.layout.stack,
			}
		}
	end
end

screen.connect_signal("property::geometry", set_wallpaper)
screen.connect_signal("screen::added", set_wallpaper)
screen.connect_signal("screen::removed", set_wallpaper)
screen.connect_signal("request::wallpaper", set_wallpaper)

-- gears.timer {
-- 	timeout   = 10,
-- 	autostart = true,
-- 	callback  = function()
-- 		for s in screen do
-- 			s:emit_signal("request::wallpaper")
-- 		end
-- 	end,
-- }

local set_tags   = function(s)
	if screen.count() == 1 then
		awful.tag({ "dev", "local", "www", "mus", "wpp", "chat" }, s, awful.layout.layouts[1])
	else
		if (s.index == 1) then
			awful.tag({ "local", "www", "wpp", "chat" }, s, awful.layout.layouts[1])
		else
			awful.tag({ "dev", "www", "mus", "disc" }, s, awful.layout.layouts[1])
		end
	end
end

local checkbox   = wibox.widget {
	checked       = false,
	color         = beautiful.purple,
	paddings      = 3,
	forced_height = 3,
	shape         = gears.shape.circle,
	widget        = wibox.widget.checkbox,
}

checkbox.buttons = gears.table.join(
	awful.button({}, 1, function()
		checkbox.checked = not checkbox.checked
	end)
)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	s:emit_signal("request::wallpaper")

	awful.layout.suit.tile.left.mirror = true

	-- Each screen has its own tag table.
	set_tags(s)

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen          = s,
		filter          = awful.widget.taglist.filter.all,
		style           = {
			shape = function(cr, width, height, _)
				-- gears.shape.parallelogram(cr, width, height, width * .85)
				gears.shape.rectangle(cr, width, height)
			end,
		},
		layout          = {
			-- spacing        = -16,
			spacing_widget = {
				color  = beautiful.indentline,
				shape  = function(cr, width, height, _)
					-- gears.shape.parallelogram(cr, width, height, width * .2)
					gears.shape.rectangle(cr, width, height)
				end,
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
							-- gears.shape.transform(gears.shape.losange):translate(3, .5)(cr, width / 1.3, height)
						end,
						widget = wibox.container.background,
					},
					{
						id     = "text_role",
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				-- left   = 12,
				-- right  = 20,
				left   = 5,
				right  = 8,
				widget = wibox.container.margin
			},
			id              = "background_role",
			widget          = wibox.container.background,
			create_callback = function(self, c3, index, objects) --luacheck: no unused args
				self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
			end,
			update_callback = function(self, c3, index, objects) --luacheck: no unused args
				-- set index to purple when tag is not empty
				if #c3:clients() > 0 then
					self:get_children_by_id("index_role")[1].fg = beautiful.purple
				else
					self:get_children_by_id("index_role")[1].fg = beautiful.bg_focus
				end
			end,
		},
		buttons         = taglist_buttons
	}

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist {
		screen  = s,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	}

	-- {{{ Mouse bindings

	-- Crear un widget para mostrar el uso de la RAM
	local right_widget_width = 70
	local right_wibar_widget_left_screen = function()
		return {
			align = "center",
			valign = "center",
			forced_width = right_widget_width,
			widget = wibox.widget.textbox
		}
	end

	local right_widget_width_right_screen = 70
	local right_wibar_widget_right_screen = function(s)
		return {
			text = s,
			align = "center",
			valign = "center",
			forced_width = right_widget_width,
			widget = wibox.widget.textbox
		}
	end
	local memwidget = right_wibar_widget_left_screen()
	vicious.register(memwidget, vicious.widgets.mem, "RAM $1%", 5)

	-- Crear un widget para mostrar el uso del CPU
	local cpuwidget = right_wibar_widget_left_screen()
	vicious.register(cpuwidget, vicious.widgets.cpu, "CPU $1%", 5)

	-- Crear un widget para mostrar WIFI
	local wifiwidget = wibox.widget.textbox()
	vicious.register(wifiwidget, vicious.widgets.wifi, function(widget, args)
		if args["{ssid}"] == "N/A" then
			return string.format("")
		end
		return string.format("%s", args["{ssid}"])
	end, 13, "wlo1")

	-- local net_wireless = net_widgets.wireless({ interface = "wlp1s0" })
	local net_wired = net_widgets.indicator({
		interfaces = { "enx00e04c36013a", },
		timeout    = 5
	})
	local net_internet = net_widgets.internet({ indent = 0, timeout = 5 })

	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))

	-- Create the wibox
	s.wibar = awful.wibox({
		position = "top",
		screen = s,
		height = 20,
		-- bg = "#282c34cc",
		-- border_width = beautiful.useless_gap,
		-- border_color = "#0000"
	})

	local slope = 0
	local right_separator = wibox.widget {
		layout = wibox.layout.fixed.horizontal,
		-- spacing        = 1,
		-- spacing_widget = {
		-- 	text   = "",
		-- 	color  = beautiful.bg_focus,
		-- 	widget = wibox.widget.textbox,
		-- },
		-- spacing_widget = {
		-- 	shape  = function(cr, width, height, _)
		-- 		gears.shape.transform(gears.shape.parallelogram)
		-- 				:rotate_at(width / 2, height / 2, 1.3)
		-- 				:scale(1, .5)
		-- 				:translate(0, width / 2.5)
		-- 		(cr, width, height, width * .15)
		-- 	end,
		-- 	color  = beautiful.indentline,
		-- 	widget = wibox.widget.separator,
		-- },
	}

	local function wibar_right_container(wgt, bg, fg, r)
		bg = bg or beautiful.bg_normal
		fg = fg or beautiful.fg_normal
		r = r or false

		local inner_margin = 5
		local wgt_with_inner_margin = wibox.container.margin(wgt, inner_margin, inner_margin)
		local wgt_with_outter_margin = wibox.container.margin(wgt_with_inner_margin, slope, slope)

		local wgt_with_bg = wibox.widget {
			wgt_with_outter_margin,
			bg = bg,
			fg = fg,
			shape = function(cr, width, height, _)
				-- gears.shape.transform(gears.shape.parallelogram)
				-- 		:scale(-1, 1)
				-- 		:translate(-width, 0)
				-- (cr, width, height, width - slope)
				gears.shape.rectangle(cr, width, height)
			end,
			widget = wibox.container.background
		}
		if r then
			return wibox.container.margin(wgt_with_bg, 0, 3)
		end

		return wgt_with_bg
	end

	local dual_slider = dual_sliders.create_dual_slider_for_screen(s.index)

	local wibar_right_widgets_right_screen = gears.table.join({
		layout = wibox.layout.fixed.horizontal,
		spacing = 5,
		dual_slider.gamma,
		dual_slider.brightness,
		-- docker_widget,
		cpu_widget({
			step_spacing = 0,
			color = beautiful.gray,
			enable_kill_button = true,
		}),
		memwidget,
		wibox.container.margin(cpuwidget, 0, 0),
	})

	local wibar_right_widgets_left_screen = gears.table.join({
		layout = wibox.layout.fixed.horizontal,
		-- spacing = slope * 1.5,
		spacing = 9,
		dual_slider.gamma,
		dual_slider.brightness,
		wifiwidget,
		net_wired,
		net_internet,
		volume_widget,
		wibox.container.margin(
			battery_widget {
				font = beautiful.font,
				show_current_level = true,
			}
			, 0, -6),
	})

	local wibar_right_widgets = s.index == 1 and wibar_right_widgets_left_screen or wibar_right_widgets_right_screen

	s.wibar:setup {
		layout = wibox.layout.align.horizontal,
		{
			-- izquierda
			layout = wibox.layout.fixed.horizontal,
			s.mytaglist,
			s.mypromptbox
		},
		-- centro
		nil,
		{
			-- derecha
			layout = wibox.layout.fixed.horizontal,
			-- spacing = 5,
			wibar_right_widgets,
			wibar_right_container(mytextclock_date, beautiful.indentline, beautiful.green),
			wibar_right_container(mytextclock_hours, beautiful.green, beautiful.indentline),
			wibox.container.background(wibox.container.margin(s.mylayoutbox, 0, 1, 0, 0), beautiful.bg_normal),
		}
	}
end)
-- }}}
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
			mouse.coords { x = 69, y = 43 }

			awful.screen.connect_for_each_screen(function(s)
				s:emit_signal("request::wallpaper")
			end)
		end,
		{ description = "change wallpaper", group = "custom" }),

	awful.key({ keySuper, }, ";", hotkeys_popup.show_help,
		{ description = "show help", group = "awesome" }),
	awful.key({ keySuper }, "y", function() awful.spawn("spotify") end,
		{ description = "open spotify", group = "applications" }),
	awful.key({ keySuper }, "i", function() awful.spawn("discord") end,
		{ description = "open discord", group = "applications" }),
	awful.key({ keySuper }, "u", function() awful.spawn("whatsapp-for-linux") end,
		{ description = "open whatsapp", group = "applications" }),

	awful.key({ keySuper, keyControl }, "a", add_tag,
		{ description = "add a tag", group = "tag" }),
	awful.key({ keySuper, keyControl }, "d", delete_tag,
		{ description = "delete the current tag", group = "tag" }),
	awful.key({ keySuper, keyControl }, "m", move_to_new_tag,
		{ description = "move the current window to a new tag", group = "tag" }),
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
	end),
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%")
	end),
	awful.key({}, "XF86AudioMute", function()
		awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")
	end),

	awful.key({}, "XF86AudioPrev", function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous") end,
		{ description = "previous music", group = "custom" }),
	awful.key({}, "XF86AudioPlay", function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause") end,
		{ description = "play/pause music", group = "custom" }),
	awful.key({}, "XF86AudioNext", function() awful.util.spawn("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next") end,
		{ description = "next music", group = "custom" }),

	awful.key({}, "XF86MonBrightnessUp", function() brightness_widget:inc() end,
		{ description = "increase brightness", group = "custom" }),
	awful.key({}, "XF86MonBrightnessDown", function() brightness_widget:dec() end,
		{ description = "decrease brightness", group = "custom" }),
	-- awful.key({ keySuper, keyControl }, "d", function() xrandr.xrandr() end),

	awful.key({ keySuper, }, "w", function() mymainmenu:show() end,
		{ description = "show main menu", group = "awesome" }),

	awful.key({ keySuper, }, "u", awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }),

	awful.key({ keySuper, }, "Tab",
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{ description = "go back", group = "client" }),

	-- Standard program
	awful.key({ keySuper, }, "h", function() awful.spawn("nautilus") end,
		{ description = "open file manager", group = "launcher" }),
	awful.key({ keySuper, }, "t", function() awful.spawn(terminal .. " -e /usr/bin/zsh") end,
		{ description = "open a terminal", group = "launcher" }),

	awful.key({ keySuper, keyControl }, "r", awesome.restart,
		{ description = "reload awesome", group = "awesome" }),
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

	-- Menubar
	awful.key({ keySuper }, "p", function() menubar.show() end,
		{ description = "show the menubar", group = "launcher" }),

	-- {{{ Personal keybindings
	awful.key({ keySuper }, "g", function() awful.util.spawn("rofi -show run") end,
		{ description = "rofi run app", group = "applications" }),
	awful.key({ keySuper }, "j", function() awful.util.spawn("rofi -show window") end,
		{ description = "rofi select window", group = "applications" }),
	awful.key({ keySuper }, "k", function() awful.util.spawn("/home/greg/repos/rofi-bluetooth/rofi-bluetooth") end,
		{ description = "rofi bluetooth", group = "applications" }),
	awful.key({ keySuper }, "l", function() awful.util.spawn("/home/greg/repos/rofi-wifi-menu/rofi-wifi-menu.sh") end,
		{ description = "rofi wifi menu", group = "applications" }),
	awful.key({ keySuper }, "b", function() awful.util.spawn("firefox") end,
		{ description = "open firefox", group = "applications" }),

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
				"xtightvncviewer"
			},

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
		properties = { floating = true }
	},

	-- Add titlebars to normal clients and dialogs
	{
		rule_any = { type = { "normal", "dialog" }
		},
		properties = { titlebars_enabled = false }
	},
}

ruled.client.append_rule {
	rule = { class = "whatsapp-for-linux" },
	properties = {
		tag       = screen[1].tags[3],
		maximized = true,
		-- switch_to_tags = true
	}
}
ruled.client.append_rule {
	rule = { class = "Spotify" },
	properties = {
		tag       = screen[2] and screen[2].tags[3] or screen[1].tags[1],
		maximized = true,
		-- switch_to_tags = true
	}
}
ruled.client.append_rule {
	rule = { class = "discord" },
	properties = {
		tag       = screen[2] and screen[2].tags[4] or screen[1].tags[3],
		maximized = true,
		-- switch_to_tags = true
	}
}

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

-- {{{ My current job
local function initialize_job_app()
	awful.spawn.single_instance(terminal .. " -e /home/greg/repos/tmuxifier/bin/tmuxifier load-session dchess",
		{ screen = screen[2] and 2 or 1, tag = "dev", maximized = true })
	awful.spawn.single_instance("spotify", { screen = screen[2] and 2 or 1, tag = "mus" })
	awful.spawn.single_instance("discord", { screen = screen[2] and 2 or 1, tag = screen[2] and "disc" or "wpp" })

	awful.spawn.single_instance("google-chrome http://localhost:3232", { screen = 1, tag = "local" })
	awful.spawn.single_instance("firefox", { screen = 1, tag = "www" })
	awful.spawn.single_instance("whatsapp-for-linux", { screen = 1, tag = "wpp" })
end

naughty.notify {
	title    = "Initialize job apps?",
	position = "top_middle",
	urgency  = "critical",
	bg       = "#8a0808",
	fg       = beautiful.fg_normal,
	timeout  = 0,
	actions  = {
		naughty.action {
			name = " Accept",
			invoke = function()
				naughty.notify {
					title   = "Job apps initialized",
					text    = "Starting...",
					timeout = 2,
				}
				initialize_job_app()
			end
		},
		naughty.action {
			name = " Refuse",
		},
	}
}
-- }}}

awesome.connect_signal("startup", function()
	awful.spawn.with_shell("autorandr main")
	awful.spawn.with_shell("picom --config ~/.config/picom/picom.config")
end)
