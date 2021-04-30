" Auto Install vim-plug
" Below scripts only works over 0.3.0 version of neovim!
" Need to check what version of neovim is."
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"----------Plug in Manger : vim-plug
call plug#begin(stdpath('data') . '/plugged')
"·Color·Scheme
"Plug 'nanotech/jellybeans.vim'
"Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
" various languages enhanced syntax
Plug 'sheerun/vim-polyglot'
"--------------------
"·Status·bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"--------------------
"·File·Explorer
Plug 'preservim/nerdtree'
" File Explorer With Icon
Plug 'ryanoasis/vim-devicons'
"--------------------
"·Bracket·Highlighter"
Plug 'luochen1990/rainbow'
"--------------------
"·Tagbar
Plug 'majutsushi/tagbar'
"--------------------
"·use·cscope·easily
Plug 'ronakg/quickr-cscope.vim'
"--------------------
Plug 'wesleyche/SrcExpl' " exploring the source code definition
" Git Interaction
Plug 'tpope/vim-fugitive'
" highlight changing
Plug 'airblade/vim-gitgutter'
call plug#end()

"========== Plugin configuration
"---------- Airline relates
" Airline diplays status of editor so don't need to showmode
" e.g. [-- INSERT --], [-- VISUAL --]
set noshowmode
" use airline theme
let g:airline_theme='raven'

" ---------- Key Map
" mapping only normal mode F8 to TagbarToggle
nnoremap <F8> :TagbarToggle<CR>
" mapping not recursively F9 to NerdtreeToogle  all mode except for INSERT Mode
noremap <F9> <Esc>:NERDTreeToggle<CR>
nnoremap <F7> :SrcExplToggle<CR>

" -----------------SrcExpl
let g:SrcExpl_winHeight = 8 "SrcExpl window height
let g:SrcExpl_refreshTime = 100 "refreshing time = 100ms
" // Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>"
" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>"
" -----------------Tagbar
" when toggle tagbar the focus will move to tagbar window
let g:tagbar_autofocus = 1

" show line number
set number
set numberwidth=2
" tab size
set tabstop=4
set shiftwidth=4
" ---------- Indent
set autoindent
set cindent
" ignore indent when the preprocessor is typed
set smartindent

" ---------- Color Scheme
set background=dark
"colorscheme jellybeans
colorscheme gruvbox
"let g:tokyonight_style = 'storm' " available: night, storm
"let g:tokyonight_enable_italic = 1
"colorscheme tokyonight

"colorscheme onedark
" highlight brackets colorful
let g:rainbow_active = 1

" ---------- Highlight
set cursorline
set hlsearch
set list
set listchars=space:·,tab:→\ ,trail:•
highlight SpecialKey ctermfg=DarkGray guifg=#A0A0A0
highlight BadWhitespace ctermbg=red guibg=darkred

"----------Custom command
command Rfm set number! list!
command Sfm set number list

" ---------- Syntax
if has("syntax")
    syntax on
endif
filetype on

" save file with encoding
set fileencoding=utf-8
set encoding=UTF-8

" ---------- Ctags!
" ctags
set tags=./tags,tags
"set tags+=~/.stdlib.tag,/home/$USER/.stdlib.tag
set tags+=/home/$USER/.tags/stdlib.tag
" set tags+=/home/$USER/.tags/dbus.tag
" ----------------------------------------
" ---------- cscope
if filereadable("./cscope.out")
	cs add cscope.out
endif
