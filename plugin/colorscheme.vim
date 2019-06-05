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

function! RandInt2(Low, High) abort
python << EOF
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
let g:environment_theme = get(g:, 'environment_theme', 0)
let g:random_scheme = get(g:, 'random_scheme', 1)
let g:default_theme_airline = get(g:, 'default_theme_airline', 'dark')
let g:default_theme = get(g:, 'default_theme', 'default')
let g:airline_integration = get(g:, 'airline_integration', 0)
let g:colorscheme_airline_correlation = get(g:, 'colorscheme_airline_correlation', 0)
let g:available_colorschemes = get(g:, 'available_colorschemes', ['blue', 'delek', 'desert', 'morning', 'ron'])
let g:available_airline_themes = get(g:, 'available_airline_themes', ['dark'])
let g:clearLineNr = get(g:, 'clearLineNr', 0)

if !exists("g:loaded_airline")
    let g:airline_integration = 0
endif
" }}

" {{ Make sure it can actually run
if !has('python3') && !has('python')
    autocmd VimEnter * echomsg string('random_colorscheme.vim: Must be compiled with either python2 or python3')
    let g:random_disabled = 1
endif
" }}
 
" {{ Function called anytime the colorscheme is to be changed randomly

function! Init(index, a_index, inside) abort

    let s:idx = a:index
    let s:aidx = a:a_index

    " Until they both have different index values
    while a:index == s:idx && a:a_index == s:aidx
        let s:p3 = 0
        if has('python3')
            let s:idx = RandInt(0, len(g:available_colorschemes) - 1)
            let s:aidx = RandInt(0, len(g:available_airline_themes) - 1)
            let s:p3 = 1
        endif

        if has('python') && !s:p3
            let s:idx = RandInt2(0, len(g:available_colorschemes) - 1)
            let s:aidx = RandInt2(0, len(g:available_airline_themes) - 1)
        endif
    endwhile

    if g:colorscheme_airline_correlation && len(g:available_airline_themes) == len(g:available_colorschemes)
        let s:aidx = s:idx
    endif

    if !g:random_disabled
        if g:random_scheme || a:inside
            try 
                let g:scheme = g:available_colorschemes[s:idx]    
                if g:airline_integration
                    let g:airline_theme = g:available_airline_themes[s:aidx]
                endif
            catch
                echo g:available_colorschemes[s:idx]    
            endtry
        elseif g:environment_theme && !g:random_scheme
            if $RANDOM_THEME
                let s:env_theme_num = $RANDOM_THEME
            else
                let s:env_theme_num = 0
            endif
            if g:colorscheme_airline_correlation && s:env_theme_num < len(g:available_airline_themes)
                let s:aidx = s:env_theme_num
            endif
            if s:env_theme_num > len(g:available_colorschemes) - 1
                let g:scheme = g:default_theme
            endif
            let g:airline_theme = g:available_airline_themes[s:aidx]
            let g:scheme = g:available_colorschemes[s:env_theme_num]
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
    
        if g:clearLineNr
            highlight clear LineNr
            highlight clear SignColumn
        endif

        return [s:idx, s:aidx]
    endif
    return [-1, -1]
endfunction

let g:indicies = Init(-1, -1, 0)

" }}

" {{{{ Other functionality

" {{ change color randomly on command
function! ChangeColour() abort
    let g:indicies = Init(g:indicies[0], g:indicies[1], 1)
    echo "\rTheme: " . g:colors_name
endfunction

nnoremap <leader>co :call ChangeColour()<cr>
" }}

" }}}}
