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

call vundle#end()

set t_Co=256

" for jellybeans
colorscheme jellybeans

" for taglist
nmap <F8> :Tagbar<CR>

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

set bg=dark
set autoindent
set cindent
set tabstop=8
set shiftwidth=8

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

" CTAGS / CSCOPE
set tags=/home/reallinux/git/linux/tags
set csprg=/usr/local/bin/cscope
cs add /home/reallinux/git/linux/cscope.out

