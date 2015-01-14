set nocompatible
set hidden
set expandtab
let mapleader = "\<space>"

" plugin manager (vim-plug)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.vim/bundle')

" custom plugins
Plug 'L9'
Plug 'tpope/vim-fugitive'
Plug 'seletskiy/vim-refugi'
Plug 'pik4ez/vim-colors-solarized'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'edsono/vim-matchit', { 'for': 'html' }
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'Shougo/unite.vim'
Plug 'sickill/vim-pasta'
Plug 'bling/vim-airline'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'kana/vim-smartinput'
Plug 'kovetskiy/ash.vim'

" Go helper. The gocode package must be installed:
" go get github.com/nsf/gocode
Plug 'Blackrush/vim-gocode'

" xkb-switch required
" see https://github.com/ierton/xkb-switch
" after installation, set chmod +x /usr/local/lib/libxkbswitch.so
Plug 'lyokha/vim-xkbswitch'

call plug#end()

" unite settings
"let g:unite_split_rule = "botleft"
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_file = $HOME.'/.vim/yankring.txt'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'direction': 'botright',
\ })
call unite#custom#alias('ash_review', 'split', 'ls')
map <C-C> :UniteClose<CR>
nmap <Leader>j :Unite file<CR>
nmap <Leader>b :Unite buffer<CR>
nmap <Leader>a :Unite ash_inbox<CR>
nmap <Leader>r :UniteResume<CR>
imap <silent><buffer><expr> <C-T> unite#do_action('split')
imap <buffer> <F5> <Plug>(unite_redraw)

" surround settings
let g:surround_45 = "\1function: \1(\r)"

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['python', 'py3kwarn']
autocmd BufNewFile,BufRead /home/tt4/mnt/* let g:syntastic_php_phpcs_args='--encoding=utf-8 --report=csv --standard=/home/tt4/work/ngs_standards/CodeSniffer/Standards/NGS/'

" ultisnips settings
let g:UltiSnipsSnippetsDir = '~/.vim/snippets'
let g:UltiSnipsSnippetDirectories = ['Ultisnips', 'snippets']
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" youcompleteme settings
let g:ycm_key_list_select_completion = ['<c-n>']
let g:ycm_key_list_previous_completion = ['<c-p>']

" airline settings
set laststatus=2
let g:airline_theme='solarized'
let g:airline_solarized_reduced = 0
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#symbol = '☼'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '│'
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#syntastic#enabled = 1
function! AirlineFixLength(...)
    let w:airline_section_z = airline#section#create(['%3p%%', 'linenr', '%3v'])
endfunction
call airline#add_statusline_func('AirlineFixLength')

" xkb-switch settings
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']

set tabstop=4
set sw=4

set background=light
set t_Co=256
colorscheme solarized

" Directories for backup and swap files
set backupdir=~/tmp/vim,~/tmp,/var/tmp,/tmp
set directory=~/tmp/vim,~/tmp,/var/tmp,/tmp

" line numbers
set rnu

" wild menu
set wildmenu

" hidden symbols
set list
set listchars=eol:¶,extends:»,tab:│·,trail:·"
let g:solarized_visibility="low"
let g:solarized_contrast="normal"
let g:solarized_termcolors=256

" press F2 to paste without indent magick
set pastetoggle=<F2>

" mappings
inoremap <C-j> <Esc>
inoremap <C-t> <C-o>:call search("[)}\"'`\\]]", 'c')<CR><Right>
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <Space><Space> :nohlsearch<CR>
cnoremap w!! w !sudo tee % >/dev/null
inoremap <C-L> <C-^>
cnoremap <C-L> <C-^>
nnoremap <Leader>c :tabnew $MYVIMRC<CR>
noremap <F8> :tabdo :bd<CR>
vmap <Leader>` y:UltiSnipsEdit<CR>Go<CR>snippet HERE<CR>endsnippet<ESC>k]p?HERE<CR>zzciw`

" Copy current file path to * buffer
nmap <F4> :let @* = expand("%")<CR>

" Ctrl-U converts previous word to upper case
inoremap <C-u> <ESC>viwgUea

" Ctrl-N breaks line in place of cursor
" Ctrl-M breaks line in place of cursor and jumps to the next space
" TODO remove space character under cursor before line breaking
" TODO create smart mapping to break arguments list inside function definition
nnoremap <C-n> i<CR><Esc>k$
nnoremap <C-m> i<CR><Esc>f<space>

" switch to previously selected tab
let g:lasttab = 1
nnoremap gl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" tabs settings
function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
        let buflist = tabpagebuflist(i)
        let winnr = tabpagewinnr(i)
        let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
        let s .= '%' . i . 'T'
        let wn = tabpagewinnr(i, '$')
        let s .= ' '
        let s .= i
        let s .= (i == t ? '%m' : '')
        let s .= ' '
        let bufnr = buflist[winnr - 1]
        let file = bufname(bufnr)
        let buftype = getbufvar(bufnr, 'buftype')

        if buftype == 'nofile'
            if file =~ '\/.'
                let file = substitute(file, '.*\/\ze.', '', '')
            endif
        else
            let file = fnamemodify(file, ':p:.')

            if strlen(file) >= 20
                let file = substitute(file, '\(.\)[^/]\+/', '\1/', 'g')
            endif
        endif

        if file == ''
            let file = '[No Name]'
        endif

        let s .= file

        if tabpagewinnr(i, '$') > 1
            let s .= '('
            let s .= (tabpagewinnr(i, '$') > 1 ? wn : '')
            let s .= ')'
        end

        let s .= ' '

        let i = i + 1
    endwhile

    let s .= '%#TabLineFill#%T'

    return s
endfunction

set showtabline=2
set tabline=%!MyTabLine()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching

" Don't use Ex mode, use Q for formatting
noremap Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

set autoindent

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
"filetype plugin indent on
filetype indent on
filetype on
filetype plugin on

augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 120 characters.
    autocmd FileType text setlocal textwidth=120

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \ exe "normal! g`\"" |
                \ endif
augroup END

augroup erlang
    au!
    autocmd FileType erlang setlocal ts=4 sts=4 sw=4 noet
augroup END

augroup php
    au!
    autocmd FileType php setlocal colorcolumn=80,120
augroup END

augroup go
    au!
    autocmd FileType go setlocal noet
augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
endif

" Auto reload vimrc on change
augroup vimrc
    au!
    au BufWritePost ~/.vimrc source % | AirlineRefresh
    augroup end
