local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/main/theme.lua")

local function set_xrandr(screen_index, brightness_percentage)
	local brightness = (brightness_percentage / 100 .. ""):gsub(",", ".")

	awful.spawn.with_shell(
		"xrandr --output $(xrandr --listmonitors | awk 'NR==1 {next} NR==" .. screen_index + 1 ..
		" {print $4; exit}') --brightness " .. brightness
	)
end

local function set_radshift(gamma)
	awful.spawn.with_shell("radshift " .. gamma * 100 .. "K")
end

local function create_dual_slider(screen_index)
	local initial_values = {
		brightness = 69,
		gamma = 45,
	}

	local gamma_gradient_color = {
		type = "linear",
		from = { 0, 0 },
		to = { 100, 10 },
		stops = { { 0, beautiful.red }, { 100, beautiful.blue } }
	}

	local brightness_gradient_color = {
		type = "linear",
		from = { 0, 0 },
		to = { 100, 10 },
		stops = { { 0, beautiful.black }, { 100, beautiful.white } }
	}

	local slider_gamma = wibox.widget {
		bar_shape    = gears.shape.rounded_rect,
		bar_height   = 3,
		bar_color    = gamma_gradient_color,
		handle_color = gamma_gradient_color,
		handle_shape = gears.shape.circle,
		value        = initial_values.gamma,
		maximum      = 100,
		minimum      = 15,
		forced_width = 85,
		widget       = wibox.widget.slider,
	}

	local slider_brightness = wibox.widget {
		bar_shape    = gears.shape.rounded_rect,
		bar_height   = 3,
		bar_color    = brightness_gradient_color,
		handle_color = brightness_gradient_color,
		handle_shape = gears.shape.circle,
		value        = initial_values.brightness,
		maximum      = 100,
		minimum      = 15,
		forced_width = 85,
		widget       = wibox.widget.slider,
	}

	slider_brightness:buttons(awful.util.table.join(
		awful.button({}, 4, function()
			initial_values.brightness = initial_values.brightness + 5
			slider_brightness.value = initial_values.brightness
			slider_brightness:emit_signal("property::brightness", slider_brightness.value) -- Emitir la señal con el nuevo valor
		end),
		awful.button({}, 5, function()
			initial_values.brightness = initial_values.brightness - 5
			slider_brightness.value = initial_values.brightness
			slider_brightness:emit_signal("property::brightness", slider_brightness.value) -- Emitir la señal con el nuevo valor
		end)
	))

	slider_gamma:buttons(awful.util.table.join(
		awful.button({}, 4, function()
			initial_values.gamma = initial_values.gamma + 5
			slider_gamma.value = initial_values.gamma
			slider_gamma:emit_signal("property::gamma", slider_gamma.value) -- Emitir la señal con el nuevo valor
		end),
		awful.button({}, 5, function()
			initial_values.gamma = initial_values.gamma - 5
			slider_gamma.value = initial_values.gamma
			slider_gamma:emit_signal("property::gamma", slider_gamma.value) -- Emitir la señal con el nuevo valor
		end)
	))

	local delay_timer_gamma = nil
	local delay_timer_brightness = nil

	slider_gamma:connect_signal("property::gamma", function(_, new_value)
		if delay_timer_gamma then
			delay_timer_gamma:stop() -- Detener el temporizador si está en ejecución
		end

		-- Crear un temporizador para ejecutar setgamma después de un leve retraso (0.5 segundos)
		delay_timer_gamma = gears.timer {
			timeout = 0.1,
			single_shot = true,
			callback = function()
				initial_values.gamma = new_value
				set_radshift(initial_values.gamma)
			end
		}
		delay_timer_gamma:start()
	end)

	slider_brightness:connect_signal("property::brightness", function(_, new_value)
		if delay_timer_brightness then
			delay_timer_brightness:stop() -- Detener el temporizador si está en ejecución
		end

		-- Crear un temporizador para ejecutar setBrightness después de un leve retraso (0.5 segundos)
		delay_timer_brightness = gears.timer {
			timeout = 0.1,
			single_shot = true,
			callback = function()
				initial_values.brightness = new_value
				set_xrandr(screen_index, initial_values.brightness)
			end
		}
		delay_timer_brightness:start()
	end)

	return { brightness = slider_brightness, gamma = slider_gamma }
end

return {
	create_dual_slider_for_screen = create_dual_slider,
	set_xrandr = set_xrandr,
	set_radshift = set_radshift
}
