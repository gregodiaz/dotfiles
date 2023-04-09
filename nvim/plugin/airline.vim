" let g:airline#extensions#whitespace#enabled = 1
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'default'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = ' '
" let g:airline#extensions#tabline#right_sep = ""
" let g:airline#extensions#tabline#right_alt_sep = ""
" let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_detect_modified = 1

" let g:airline_section_b = '%-0.14{getcwd()}'
" x->%P y->%B
let g:airline_section_x = ""
let g:airline_section_y = ""
let g:airline_section_z = "%3p%% %l/%L:%v"
let g:airline_left_sep = ""
let g:airline_left_alt_sep = ""
let g:airline_right_sep = ""
let g:airline_right_alt_sep = ""
" let g:airline_theme = "base16_gruvbox_dark_soft" "-> :AirlineTheme <theme>
let g:airline_theme = "deus" "-> :AirlineTheme <theme>
