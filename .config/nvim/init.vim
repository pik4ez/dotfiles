set nocompatible
set hidden

augroup run_after_plug_end
au!
    call plug#begin('~/.vim/plugged')

    let mapleader="\<space>"
    let g:vim_indent_cont = shiftwidth()

    Plug 'icymind/NeoSolarized'

    Plug 'jiangmiao/auto-pairs'

    Plug 'junegunn/fzf', {'do': './install --all'}

    Plug 'jxnblk/vim-mdx-js'

    Plug 'junegunn/fzf.vim'
        let g:fzf_prefer_tmux = 0
        let g:fzf_layout = { 'down': '40%' }

        func! _select_file()
            call fzf#run(fzf#wrap({'source': 'prols', 'options': '--sort --no-exact'}))
        endfunc!

        func! _select_buffer()
            call fzf#vim#buffers({'options': '--sort --no-exact'})
        endfunc!

        noremap <silent> <leader>f :call _select_file()<CR>
        noremap <silent> <leader>b :call _select_buffer()<CR>

    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
        let g:go_fmt_command = "goimports"
        let g:go_snippet_engine = "skip"

    Plug 'dart-lang/dart-vim-plugin'
        let dart_html_in_string=v:true
        let g:dart_style_guide = 2
        let g:dart_format_on_save = 1

    let g:python3_host_prog = expand('/home/tt4/.pyenv/shims/python')

    Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
        let g:pymode = 1
        let g:pymode_indent = 1
        let g:pymode_breakpoint = 0

    Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
        set updatetime=300
        set signcolumn=yes

        let g:coc_global_extensions = [
            \ 'coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier',
            \ 'coc-snippets',
            \ 'coc-go',
            \ 'coc-python',
            \ 'coc-flutter'
            \ ]

        inoremap <silent><expr> <tab> pumvisible() ?
            \ "\<c-n>" : 
            \ coc#expandable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<cr>" :
            \ "\<tab>"
        inoremap <silent><expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
        inoremap <silent><expr> <cr> !pumvisible() ?
            \ "\<cr>" :
            \ _check_back_space() ?
            \ "\<c-n>\<c-p>" :
            \ coc#_select_confirm()

        func! _check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
        endfunc

        let g:coc_snippet_next = '<c-j>'
        let g:coc_snippet_prev = '<c-k>'
        inoremap <silent><expr> <c-space> coc#refresh()

        nnoremap <leader>ii :CocCommand editor.action.organizeImport<cr>

        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

    Plug 'lepture/vim-jinja'

    Plug 'prettier/vim-prettier', {
    \ 'do': 'npm install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

    Plug 'peitalin/vim-jsx-typescript'
    Plug 'maxmellon/vim-jsx-pretty'

    Plug 'vim-scripts/surround.vim'
        vmap ( S)i<esc>
        vmap ) S)%a<esc>
        vmap [ S]i<esc>
        vmap ] S]%a<esc>
        vmap { S}i<esc>
        vmap } S}%a<esc>
        vmap " S"i<esc>
augroup end

call plug#end()
au VimEnter * au! run_after_plug_end

augroup vimrc
    au!
    au BufWritePost */.config/nvim/init.vim source %
augroup end

augroup python
    au!
    au BufWritePost *.py :PymodeLintAuto
augroup end

set termguicolors
colorscheme NeoSolarized

set rnu
set nowrap
set list
set lcs=trail:·,tab:\|\· " <- trailing space here
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

nnoremap <f8> :bufdo bd<cr>
nnoremap <silent> ga <c-^>
nnoremap <silent> gt :bnext<cr>
nnoremap <silent> gT :bprev<cr>
nnoremap <leader>` :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>d :bd<cr>
nnoremap // :noh<cr>
nnoremap <leader>\ :CocCommand snippets.editSnippets<cr>

nnoremap [<leader> O<esc>j
nnoremap ]<leader> o<esc>k

autocmd FileType css setlocal ts=2 sts=2 sw=2
autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd FileType json setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType typescript.tsx setlocal ts=2 sts=2 sw=2
autocmd FileType markdown.mdx setlocal ts=2 sts=2 sw=2
autocmd FileType dart setlocal ts=2 sts=2 sw=2
