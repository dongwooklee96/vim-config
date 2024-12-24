set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'airblade/vim-gitgutter' " vim with git status(added, modified, and removed lines)
Plugin 'tpope/vim-fugitive' " vim with git command(e.g., Gdiff)
Plugin 'vim-airline/vim-airline' " vim status bar
Plugin 'vim-airline/vim-airline-themes'
Plugin 'blueyed/vim-diminactive'
Plugin 'hari-rangarajan/CCTree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'voldikss/vim-floaterm'
Plugin 'skywind3000/asyncrun.vim'

call vundle#end()

filetype plugin indent on    " required

set t_Co=256

" for jellybeans
colorscheme jellybeans

" for NERDTree
map <F1> :NERDTreeToggle<cr>

" for taglist
nmap <F7> :Tagbar<CR>

" for indent guide
let g:indentguides_spacechar = '┆'
let g:indentguides_tabchar = '|'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" for vim-airline
let g:airline#extensions#tabline#enabled = 1 " turn on buffer list
let g:airline_theme='hybrid'
set laststatus=2 " turn on bottom bar
let mapleader = ","
nnoremap <leader>q :bp<CR>
nnoremap <leader>w :bn<CR>

" for blueyed/vim-diminactive
let g:diminactive_enable_focus = 1

syntax enable
filetype indent on
highlight Comment term=bold cterm=bold ctermfg=4

set smartindent
set bg=dark
set autoindent
set cindent
set tabstop=4
set shiftwidth=4

set expandtab
set et

set nu

" 불필요한 공백이나 들여쓰기에 빨간색으로 보여준다.
if has("autocmd")
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$\|\t/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$\|\t/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$\|\t/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$\|\t/
  autocmd BufWinLeave * call clearmatches()
endif

" 파일을 열었을 때 이전의 위치를 기억하고 다시 그 위치에서 열어주는 기능
if has("autocmd")
  au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g '\"" |
endif

" CTRL + 이동키로 파일간 이동 가능하게 하는 핫키

nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" SHFIT + 이동키로 창 분할 이동
nnoremap <S-j> <c-w>j
nnoremap <S-k> <c-w>k
nnoremap <S-h> <c-w>h
nnoremap <S-l> <c-w>l

" CTAGS / CSCOPE
set tags=/home/reallinux/git/linux/tags
set csprg=/usr/local/bin/cscope
cs add /home/reallinux/git/linux/cscope.out

" BUFFER 관련 명령어
nnoremap <C-n> :enew<Enter>         " 새로운 버퍼를 연다
nnoremap <C-d> :bp <BAR> bd #<Enter> " 현재 버퍼를 닫고 이전 버퍼로 이동
nnoremap <F5> :bprevious!<Enter>    " 이전 버퍼로 이동
nnoremap <F6> :bnext!<Enter>        " 다음 버퍼로 이동

" last modified location
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" fzf
nnoremap <C-p> :Files<Cr>
nnoremap <space>f :Ag<CR>

" floatterm
nnoremap <silent> <F12> :FloatermToggle<CR>
tnoremap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>

" vim-fugitive
nnoremap <silent> <F2> :Git blame --date short<CR>
nnoremap <space>gd :Gvdiffsplit<CR>

" change swap & undo
set undofile
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

set backup                        " enable backups
set swapfile                      " enable swaps
set undodir=$HOME/.vim/tmp/undo     " undo files
set backupdir=$HOME/.vim/tmp/backup " backups
set directory=$HOME/.vim/tmp/swap   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" 일반 모드와 비주얼 모드에서 Ctrl+/ 매핑
" 참고: 터미널에서는 Ctrl+/가 Ctrl+_로 인식됨
noremap <C-_> :call ToggleComment()<CR>
vnoremap <C-_> :call ToggleComment()<CR>

function! ToggleComment()
    " 현재 파일 타입에 따른 주석 문자 설정
    let comment_char = '#'
    if &filetype == 'cpp' || &filetype == 'javascript' || &filetype == 'java' || &filetype == 'php'
        let comment_char = '//'
    elseif &filetype == 'vim'
        let comment_char = '"'
    endif

    " 현재 라인의 첫 번째 non-blank 문자 확인
    let line = getline('.')
    let has_comment = match(line, '^\s*' . comment_char) >= 0

    if has_comment
        " 주석 제거
        execute ':s/^\(\s*\)' . comment_char . '\s\?/\1/'
    else
        " 주석 추가
        execute ':s/^\(\s*\)/\1' . comment_char . ' /'
    endif
endfunction
