" {{ Generate random integer to choose color scheme
function! RandInt(Low, High) abort
python3 << EOF
import vim
import random
idx = random.randint(int(vim.eval('a:Low')), int(vim.eval('a:High')))
vim.command("let index = {}".format(idx))
EOF
return index
endfunction
" }}

" {{ default settings
let g:random_disabled = get(g:, 'random_disabled', 0)
let g:random_scheme = get(g:, 'random_scheme', 1)
let g:default_theme_airline = get(g:, 'default_theme_airline', 'dark')
let g:default_theme = get(g:, 'default_theme', 'default')
let g:airline_integration = get(g:, 'airline_integration', 0)
let g:colorscheme_airline_correlation = get(g:, 'colorscheme_airline_correlation', 0)
let g:available_colorschemes = get(g:, 'available_colorschemes', ['blue', 'delek', 'desert', 'morning', 'ron'])
let g:available_airline_themes = get(g:, 'available_airline_themes', ['dark'])
" }}
"

if !has('python3') && !has('python')
    autocmd VimEnter * echomsg string('random_colorscheme.vim: Must be compiled with either python2 or python3')
    let g:random_disabled = 1
endif
 

let s:idx = RandInt(0, len(g:available_colorschemes) - 1) " make sure that s:available_colorschemes and s:available_airline_themes are equal in length
let s:aidx = RandInt(0, len(g:available_airline_themes) - 1) " make sure that s:available_colorschemes and s:available_airline_themes are equal in length

if g:colorscheme_airline_correlation && len(g:available_airline_themes) == len(g:available_colorschemes)
    let s:aidx = s:idx
endif



if !g:random_disabled
    if g:random_scheme
        try 
            let g:scheme = g:available_colorschemes[s:idx]    
            if g:airline_integration
                let g:airline_theme = g:available_airline_themes[s:aidx]
            endif
        catch
            echo g:available_colorschemes[s:idx]    
        endtry
    else
        try
            " colorscheme space-vim-dark
            let g:scheme = g:default_theme
            if g:airline_integration
                let g:airline_theme = g:default_theme_airline
            endif
        catch
        endtry
    endif
    exec 'colorscheme ' . g:scheme   
endif

