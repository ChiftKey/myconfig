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
" Color Scheme
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
" various languages enhanced syntax
Plug 'sheerun/vim-polyglot'

" fzf
Plug 'junegunn/fzf.vim'
Plug '~/.fzf'

"--------------------
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"--------------------
" File Explorer
Plug 'preservim/nerdtree'
" File Explorer With Icon
Plug 'ryanoasis/vim-devicons'
"--------------------
" Bracket Highlighter"
Plug 'luochen1990/rainbow'
"--------------------
" Tagbar
Plug 'majutsushi/tagbar'

"--------------------
" use cscope easily
Plug 'ronakg/quickr-cscope.vim'
"--------------------
"Plug 'wesleyche/SrcExpl' " exploring the source code definition
" Git Interaction
Plug 'tpope/vim-fugitive'
" highlight changing
Plug 'airblade/vim-gitgutter'
" Language auto complete
" NOTE : required clangd
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Auto complete bracket, quotes
"Plug 'raimondi/delimitmate'

call plug#end()

"========== Plugin configuration
"---------- Rainbow bracket
let g:rainbow_active = 1
"---------- Airline relates
" Airline diplays status of editor so don't need to showmode
" e.g. [-- INSERT --], [-- VISUAL --]
set noshowmode
" use airline theme
let g:airline_theme='raven'
" use airline tabline extension : customized tab info
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_count = 0

"---------- Tagbar relates
" when toggle tagbar the focus will move to tagbar window
let g:tagbar_autofocus = 1
" mapping only normal mode F8 to TagbarToggle
nnoremap <F8> :TagbarToggle<CR>

"---------- NERDTree relates
" mapping not recursively F9 to NerdtreeToogle  all mode except for INSERT Mode
noremap <F9> <Esc>:NERDTreeToggle<CR>

"---------- Source Explorer releates
nnoremap <F7> :SrcExplToggle<CR>
let g:SrcExpl_winHeight = 8 "SrcExpl window height
let g:SrcExpl_refreshTime = 100 "refreshing time = 100ms
" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"
" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

" show line number
set number
set numberwidth=2
" tab size
set tabstop=4
set shiftwidth=4
"---------- Indent
set autoindent
set cindent
" ignore indent when the preprocessor is typed
set smartindent
set smarttab                            " make <tab> and <backspace> smarter"
set noexpandtab                         " use tabs, not spaces"

" Using clipboard
set clipboard=unnamedplus
vmap <C-c> "+y
map <C-v> <ESC>"+p<CR>

" Buffer change keymap
map <leader>bn :bn<CR>
map <leader>bp :bp<CR>
map <leader>bd :bd<CR>

" fzf keymap
nnoremap <silent> ,f :FZF<cr>
nnoremap <silent> ,F :FZF ~<cr>

" ---------- Color Scheme
set background=dark
"colorscheme hybrid
"colorscheme material
"colorscheme onedark
colorscheme jellybeans
"colorscheme gruvbox
" set termguicolors
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 0
"colorscheme tokyonight

" ---------- Highlight
set cursorline
set hlsearch
set list
set listchars=space:·,tab:→\ ,trail:•
highlight SpecialKey ctermfg=DarkGray guifg=#A0A0A0
"highlight BadWhitespace ctermbg=red guibg=darkred

"----------Search
set incsearch " show incremental search results as you type
"without capital character -> ignore
"more than one capatal character -> case sensitve
set ignorecase smartcase

"----------
set noswapfile

" Clear highlight for search result				[,] -> [Space key]
nnoremap ,<space> :noh<CR>
" Trim unwanted trail space
nnoremap ,s :%s/\s\+$//e<CR>
" Toggle line number & white space formatting, GitGutter 	[,] -> [m]
nnoremap ,m :set number! list!<CR>:GitGutterToggle<CR>
"----------C code auto formatting
" NOTE : asytle is required
" auto formatting like linux kernel coding
nnoremap ,c :%!astyle --style=linux --pad-oper --pad-comma --indent-switches --indent=tab
			\--attach-return-type --break-one-line-headers
			\--align-pointer=name --align-reference=name<CR>
" TCC Style
nnoremap ,t :%!astyle --style=bsd --indent=tab --indent-switches --pad-header --pad-oper --pad-comma --align-pointer=name<CR>
" nnoremap ,g :%!astyle --style=linux --indent-switches --pad-header --pad-oper --delete-empty-lines --indent=tab<CR>
" autocmd BufWritePre *.h,*.hpp,*.c,*.cpp :%!astyle --style=otbs --pad-oper --delete-empty-lines --indent=tab

" Compile & Run
" noremap <Ctrl><F5> !gcc -o hsomename % && ./somename
nnoremap ,<F5> :!gcc -Wall % && ./a.out <CR>
nnoremap ,<F6> :!gcc -Wall %<CR>
nnoremap ,<F7> :!gcc -Wall -g %<CR>
" map <F8> :w <CR> :!gcc % && ./a.out <CR>
" map <F8> :w <CR> :!gcc % -o %< && ./%< <CR>

" ---------- Syntax
if has("syntax")
    syntax on
endif
filetype on

" save file with encoding
set fileencoding=utf-8
set encoding=UTF-8

" ----------Ctags!
" ctags
set tags=./tags,tags
" set tags+=~/.stdlib.tag,/home/$USER/.stdlib.tag
set tags+=/home/$USER/.tags/stdlib.tag
" set tags+=/home/$USER/.tags/dbus.tag
" ---------- cscope
function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
" else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
        endif
endfunction
au BufEnter /* call LoadCscope()

"----------Coc.nvim relates!!!
source ~/.config/nvim/coc-nvim.vim
