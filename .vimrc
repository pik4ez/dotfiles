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
Plug 'pik4ez/vim-colors-solarized'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc', { 'do': 'make' }
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'yuku-t/unite-git'
Plug 'sickill/vim-pasta'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'kana/vim-smartinput'
Plug 'seletskiy/vim-pythonx'
Plug 'nvie/vim-flake8'
Plug 'fatih/vim-go'

" xkb-switch required
" see https://github.com/ierton/xkb-switch
" after installation, set chmod +x /usr/local/lib/libxkbswitch.so
Plug 'lyokha/vim-xkbswitch'

call plug#end()

" gui font for mac
set guifont=Monaco\ for\ Powerline:h12

set tags=./tags;,tags;

" unite settings
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_file = $HOME.'/.vim/yankring.txt'
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '-i --line-numbers --nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_grep_max_candidates = 200

call unite#custom#source(
\ 'file,file/new,buffer,file_rec,file_rec/async,git_cached,git_untracked',
\ 'matchers', 'matcher_fuzzy'
\ )
call unite#custom#source(
\ 'file,file/new,buffer,file_rec,file_rec/async,git_cached,git_untracked',
\ 'ignore_pattern', '\<nodejs\>\|\<node_modules\>'
\ )
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'direction': 'botright',
\ })
call unite#filters#sorter_default#use(['sorter_selecta'])
nmap <Leader>j :Unite -hide-source-names git_cached git_untracked buffer<CR>
nmap <Leader>b :Unite buffer<CR>
nmap <Leader>r :UniteResume<CR>
function! s:unite_my_settings()
    imap <buffer> <C-n> <Plug>(unite_select_next_line)
    imap <buffer> <C-p> <Plug>(unite_select_previous_line)
    imap <buffer> <C-j> <Plug>(unite_exit)
endfunction

" surround settings
let g:surround_45 = "\1function: \1(\r)"

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8']
autocmd BufNewFile,BufRead /home/tt4/mnt/* let g:syntastic_php_phpcs_args='--encoding=utf-8 --report=csv --standard=/home/tt4/work/ngs_standards/CodeSniffer/Standards/NGS/'

" neocomplete settings start
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "") . "\<CR>"
endfunction
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
" neocomplete settings end

" neosnippet settings start
" Disable built-in snippets.
let g:neosnippet#disable_runtime_snippets = {
    \   '_' : 1,
    \ }
" Path to snippets.
let g:neosnippet#snippets_directory = '~/.vim/neosnippets'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
"if has('conceal')
  "set conceallevel=2 concealcursor=niv
"endif
" neosnippet settings end

" airline settings
set laststatus=2
let g:airline_theme='solarized'
let g:airline_solarized_reduced = 0
let g:airline_powerline_fonts=1
let g:airline#extensions#whitespace#symbol = '☼'
let g:airline#extensions#syntastic#enabled = 1
function! AirlineFixLength(...)
    let w:airline_section_z = airline#section#create(['%3p%%', 'linenr', '%3v'])
endfunction
call airline#remove_statusline_func('AirlineFixLength')
call airline#add_statusline_func('AirlineFixLength')

" xkb-switch settings
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']

" disable scratch window
set completeopt-=preview

set showtabline=0
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
let g:solarized_italic=0

" disable visual bells
set vb

" press F2 to paste without indent magick
set pastetoggle=<F2>

" mappings
nmap <Leader>w :w<CR>
nmap <Leader>d :bd<CR>
nmap gt :bn<CR>
nmap gT :bp<CR>
nmap <Leader>u :NeoSnippetEdit<CR>
inoremap <C-j> <Esc>
inoremap <C-t> <C-o>:call search("[)}\"'`\\]]", 'c')<CR><Right>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> :left<CR>
nnoremap <silent> <Space><Space> :nohlsearch<CR>
cnoremap w!! w !sudo tee % >/dev/null
nnoremap <Leader>c :e $MYVIMRC<CR>
noremap <F8> :bufdo bdelete<CR>

" cd to work dirs
command! Wa cd ~/work/avito
command! Was cd ~/work/avito-segm
command! Wav cd ~/work/avito-vagrant
command! Wse cd ~/work/service-eventiy
command! Wspa cd ~/work/service-product-ads
command! Wspac cd ~/work/service-product-ads-client
command! Wscm cd ~/work/service-category-mapper
command! Wscmc cd ~/work/service-category-mapper-client
command! Wau cd ~/work/avito-utils
command! Waus cd ~/work/avito-utils-sphinx
command! Wspi cd ~/work/service-phone-info

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

" switch to previously selected buffer
nnoremap gl :b#<CR>

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

augroup confluence
        au!
        au BufRead /tmp/vimperator-confluence* set ft=html.confluence | :call HtmlBeautify()<CR>
        au BufRead /tmp/vimperator-confluence* map <buffer> <Leader>t :%s/\v[\ \t\n]+\<p\>([\ \t\n]+\<br\>)?[\ \t\n]+\<\/p\>/<CR>
augroup end

augroup erlang
    au!
    autocmd FileType erlang setlocal ts=4 sts=4 sw=4 noet
augroup END

augroup php
    au!
    autocmd FileType php setlocal colorcolumn=80,120
augroup END

augroup html
    au!
    autocmd FileType html setlocal et
augroup END

augroup go
    au!
    autocmd FileType go setlocal noet
augroup END

augroup python
    au!
    autocmd FileType python setlocal colorcolumn=79,120
augroup END

augroup unite_setting
    au!
    au FileType unite call s:unite_my_settings()
augroup end

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

" Make pizdato
nnoremap <Leader>m :call TryToReduce()<CR>
function! TryToReduce()
    let startLine = line(".")
    let content = getline(startLine)
    let content = substitute(content, "[,\(]", "&\r", "g")
    let content = substitute(content, "[\)]", "\r&", "g")
    let content = substitute(content, "\(\r\r\)", "()", "g")
    let content = substitute(content, "\rarray\r", "array", "g")
    execute 'normal S'
    execute 'normal i' . content
    let currentLine = line(".")
    let cow = currentLine - startLine + 2
    execute 'normal ' . (startLine - 1) . 'gg'
    execute 'normal ' . cow . '=='
    execute 'normal ' . startLine . 'gg^'
endfunction
