if !exists('*autoload#save_and_exec')
    
    function! autoload#save_and_exec() abort

        if &filetype == 'vim'

            :silent! write
            :source %

        elseif &filetype == 'lua'

            :silent! write
            :luafi %

        endif


        return

    endfunction
endif

" if exists('g:neovide')
"   let g:neovide_input_use_logo=v:true
"   " copy
"   vnoremap <D-c> "+y

"   " paste
"   nnoremap <D-v> "+p
"   inoremap <D-v> <Esc>"+pa
"   cnoremap <D-v> <c-r>+

"   " undo
"   nnoremap <D-z> u
"   inoremap <D-z> <Esc>ua
" endif

