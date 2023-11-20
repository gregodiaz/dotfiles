local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/main/theme.lua")

local gamma_list = {
	"1.00000000:0.18172716:0.00000001", -- 1000K
	"1.00000000:0.42322816:0.02614239",
	"1.00000000:0.54360078:0.08679949",
	"1.00000000:0.64373109:0.28819679",
	"1.00000000:0.71978051:0.42860152",
	"1.00000000:0.77987809:0.54642268",
	"1.00000000:0.82854786:0.64816570", -- 4000K
	"1.00000000:0.86860704:0.73688797", -- 4500K
	"1.00000000:0.90198230:0.81465502",
	"1.00000000:0.93853986:0.88130458",
	"1.00000000:0.97107439:0.94305985",
	"1.00000000:1.00000000:1.00000000", -- 6500K
	"0.95160805:0.98083355:1.00000000",
	"0.91194747:0.94470005:1.00000000",
	"0.87906581:0.92357340:1.00000000",
	"0.85139976:0.90559011:1.00000000",
	"0.82782980:0.89011714:1.00000000",
	"0.80753191:0.87667891:1.00000000",
	"0.78988728:0.86491137:1.00000000", -- 10000K
}

local rgb_list = {
	"rgb(255, 46, 0)", -- 1000K
	"rgb(255, 109, 0)",
	"rgb(255, 137, 18)",
	"rgb(255, 161, 72)",
	"rgb(255, 180, 107)",
	"rgb(255, 196, 137)",
	"rgb(255, 209, 163)", -- 4000K
	"rgb(255, 221, 186)", -- 4500K
	"rgb(255, 232, 206)",
	"rgb(255, 243, 226)",
	"rgb(255, 251, 243)",
	"rgb(255, 255, 255)", -- 6500K
	"rgb(245, 243, 255)",
	"rgb(235, 240, 255)",
	"rgb(227, 238, 255)",
	"rgb(220, 236, 255)",
	"rgb(214, 235, 255)",
	"rgb(208, 234, 255)",
	"rgb(202, 233, 255)", -- 10000K
}

local function set_xrandr(screen_index, brightness_percentage, gamma_index)
	awful.spawn.with_shell((
		"xrandr --output $(xrandr --listmonitors | awk 'NR==1 {next} NR==" ..
		screen_index + 1 ..
		" {print $4; exit}') --brightness " ..
		brightness_percentage / 100 ..
		" --gamma " ..
		gamma_list[gamma_index]
	):gsub(",", "."))
end

local function set_xrandr_and_redshift(screen_index, brightness_percentage, gamma)
	awful.spawn.with_shell("redshift -x")
	awful.spawn.with_shell((
		"xrandr --output $(xrandr --listmonitors | awk 'NR==1 {next} NR==" ..
		screen_index + 1 ..
		" {print $4; exit}') --brightness " ..
		brightness_percentage / 100 ..
		" | redshift -PO " ..
		gamma * 100
	):gsub(",", "."))
end

local function create_dual_slider(screen_index)
	local initial_values = {
		brightness = 80,
		gamma_index = 7,
		gamma = 45
	}

	-- Brightness

	local brightness_gradient_color = {
		type = "linear",
		from = { 0, 0 },
		to = { 100, 10 },
		stops = { { 0, "#1f1f1f" }, { 100, "#FFF" } }
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

	local delay_timer_brightness = nil

    local function apply_changes()
        local brightness = initial_values.brightness
        local gamma = initial_values.gamma
        set_xrandr_and_redshift(screen_index, brightness, gamma)
    end

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
				-- set_xrandr_and_redshift(screen_index, initial_values.brightness, initial_values.gamma)
				apply_changes()
			end
		}
		delay_timer_brightness:start()
	end)

	-- Gamma Index

	-- gamma_list[1] "1.00000000:0.18172716:0.00000000" => x255 => RGB(255, 46, 0) => #FF2E00
	-- gamma_list[#gamma_list] "0.78988728:0.86491137:1.00000000" => x255 => RGB(202, 220, 255) => #CADCFF
	-- local gamma_index_gradient_color = {
	-- 	type = "linear",
	-- 	from = { 0, 0 },
	-- 	to = { 100, 10 },
	-- 	stops = { { 0, "#FF2E00" }, { 100, "#CADCFF" } }
	-- }
	--
	-- local slider_gamma_index = wibox.widget {
	-- 	bar_shape    = gears.shape.rounded_rect,
	-- 	bar_height   = 3,
	-- 	bar_color    = gamma_index_gradient_color,
	-- 	handle_color = gamma_index_gradient_color,
	-- 	handle_shape = gears.shape.circle,
	-- 	value        = initial_values.gamma_index_index,
	-- 	maximum      = 19,
	-- 	minimum      = 1,
	-- 	forced_width = 85,
	-- 	widget       = wibox.widget.slider,
	-- }
	--
	-- slider_gamma_index:buttons(awful.util.table.join(
	-- 	awful.button({}, 4, function()
	-- 		initial_values.gamma_index_index = initial_values.gamma_index + 1
	-- 		slider_gamma_index.value = initial_values.gamma_index
	-- 		slider_gamma_index:emit_signal("property::gamma_index", slider_gamma_index.value) -- Emitir la señal con el nuevo valor
	-- 	end),
	-- 	awful.button({}, 5, function()
	-- 		initial_values.gamma_index_index = initial_values.gamma_index - 1
	-- 		slider_gamma_index.value = initial_values.gamma_index
	-- 		slider_gamma_index:emit_signal("property::gamma_index", slider_gamma_index.value) -- Emitir la señal con el nuevo valor
	-- 	end)
	-- ))
	--
	-- local delay_timer_gamma_index = nil
	--
	-- slider_gamma_index:connect_signal("property::gamma_index", function(_, new_value)
	-- 	if delay_timer_gamma_index then
	-- 		delay_timer_gamma_index:stop() -- Detener el temporizador si está en ejecución
	-- 	end
	--
	-- 	-- Crear un temporizador para ejecutar setgamma_index después de un leve retraso (0.5 segundos)
	-- 	delay_timer_gamma_index = gears.timer {
	-- 		timeout = 0.1,
	-- 		single_shot = true,
	-- 		callback = function()
	-- 			initial_values.gamma_index_index = new_value
	-- 			set_xrandr(screen_index, initial_values.brightness, initial_values.gamma_index_index)
	-- 		end
	-- 	}
	-- 	delay_timer_gamma_index:start()
	-- end)

	-- Gamma

	local gamma_gradient_color = {
		type = "linear",
		from = { 0, 0 },
		to = { 100, 10 },
		-- stops = { { 0, "#F60" }, { 100, "#09F" } }
		-- stops = { { 0, "#FFCC99" }, { 100, "#66AAFF" } }
		stops = { { 0, beautiful.red }, { 100, beautiful.blue } }
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
				-- set_xrandr_and_redshift(screen_index, initial_values.brightness, initial_values.gamma)
				apply_changes()
			end
		}
		delay_timer_gamma:start()
	end)

	return { brightness = slider_brightness, gamma = slider_gamma }
end

return {
	create_dual_slider_for_screen = create_dual_slider,
	set_xrandr = set_xrandr,
	set_xrandr_and_redshift = set_xrandr_and_redshift
}
