vim.g.mapleader = " "
vim.g.snippets = "luasnip"

local opt = vim.o

local tab = 2
opt.expandtab = false
opt.tabstop = tab
opt.softtabstop = tab
opt.shiftwidth = tab

opt.wrap = false
opt.linebreak = false
opt.breakindent = false

opt.number = true  -- Muestra números de línea en la ventana
opt.relativenumber = true  -- Muestra números de línea relativos
opt.cursorline = true  -- Resalta la línea actual con un fondo diferente
opt.conceallevel = 3  -- Controla la ocultación de texto (puede ocultar algunos caracteres)
opt.hidden = true  -- Permite ocultar buffers en lugar de cerrarlos
opt.smartindent = true  -- Habilita el auto-indentado inteligente
opt.autoindent = true  -- Habilita el auto-indentado
opt.errorbells = false  -- Desactiva las campanas de error
opt.swapfile = false  -- Desactiva la creación de archivos de intercambio
opt.undofile = true  -- Habilita la grabación de cambios en archivos de respaldo
opt.undodir = os.getenv "HOME" .. "/.cache/nvim/undodir"  -- Establece la ubicación de los archivos de historial de cambios
opt.incsearch = true  -- Habilita la búsqueda incremental
opt.ignorecase = true  -- Hace que las búsquedas sean insensibles a mayúsculas/minúsculas
opt.smartcase = true  -- Cambia a búsqueda insensible a mayúsculas si se utiliza una letra mayúscula
opt.termguicolors = true  -- Habilita el soporte de colores de 24 bits (truecolor)
opt.scrolloff = 8  -- Establece el número de líneas para mantener en pantalla al hacer desplazamiento
opt.sidescrolloff = 8  -- Establece el número de columnas para mantener en pantalla al hacer desplazamiento lateral
opt.showmode = false  -- Desactiva la visualización del modo actual (por ejemplo, "-- INSERT --")
opt.clipboard = "unnamedplus"  -- Utiliza el portapapeles del sistema
opt.splitbelow = false  -- Abre nuevas divisiones arriba en lugar de abajo
opt.splitright = true  -- Abre nuevas divisiones a la derecha en lugar de a la izquierda
opt.autowrite = true  -- Guarda automáticamente los archivos antes de cambiar de buffer
opt.laststatus = 3  -- Siempre muestra la línea de estado
opt.cmdheight = 1  -- Establece la altura del espacio de comandos (línea de comandos)
opt.updatetime = 50  -- Establece el tiempo de actualización de ciertas operaciones en milisegundos
opt.signcolumn = "yes"  -- Siempre muestra la columna de signos (indicadores de cambios)
opt.equalalways = false  -- No ajusta automáticamente la altura de las divisiones al editar varios archivos

if vim.fn.has "nvim-0.9.0" == 1 then
	opt.splitkeep = "screen"
	opt.shortmess = "filnxtToOFWIcC"
end
