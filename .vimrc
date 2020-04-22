execute pathogen#infect('~/.vim/bundle/{}')

let mapleader=","
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set laststatus=2
set noshowmatch
let g:loaded_matchparen=1
set incsearch
set hlsearch
set number
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set nocursorline
set nocursorcolumn
set scrolljump=10
set lazyredraw
set cmdheight=1
set switchbuf=useopen
" always show tab bar at the top
set showtabline=2
set winwidth=79
" set shell vim should use
set shell=bash
" makes bash aliases available
let $BASH_ENV="~/.bashrc"
" prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" enable highlighting for syntax
syntax on
" enable file type detection.
" use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
autocmd Filetype gitcommit setlocal spell textwidth=72
autocmd FileType python setlocal shiftwidth=2 softtabstop=2 expandtab
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
" fix slow O inserts
set timeout timeoutlen=1000 ttimeoutlen=100
" turn folding off for real, hopefully
" set foldmethod=manual
set nofoldenable
" insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces
" if a file is changed outside of vim, automatically reload it without asking
set autoread
set t_Co=256
set background=dark
colorscheme grb256
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader><leader> <c-^>
map <Space><Space> :ccl<cr>
nnoremap <leader>c :!chrome-cli reload<cr>
nnoremap <leader>cf :let @*=expand("%")<CR>
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'
" I think this tells vim to set the context of autocomplete to buffers only. (??)
set complete-=i

" testing
let g:test#preserve_screen = 1
let test#strategy = "vimterminal"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>
let g:test#javascript#jest#executable = 'yarn test'

" command-t
if &term =~ "xterm" || &term =~ "screen"
    let g:CommandTCancelMap = ['<ESC>', '<C-c>']
endif
let g:CommandTWildIgnore=&wildignore . ",*/node_modules,vendor,build,venv,__pycache__,coverage,dist,lib"
let g:CommandTTraverseSCM="pwd:"
map <leader>f :CommandT<CR>

" ag
if executable('ag')
    set grepprg=ag\ -S\ --nogroup\ --no-color
endif
nnoremap  \ :Ag!<SPACE>

function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

" function key maps
map <leader>n :call RenameFile()<cr>
