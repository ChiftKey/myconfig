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

"----------[COLOR SCHEME]----------
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'sjl/badwolf'
Plug 'sainnhe/sonokai'
"Plug 'w0ng/vim-hybrid'
"Plug 'ayu-theme/ayu-vim' " or other package manager

" various languages enhanced syntax
Plug 'sheerun/vim-polyglot'
" Bracket Highlighter"
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

"----------[FZF : Fuzzy finder]----------
Plug 'junegunn/fzf.vim'
Plug '~/.fzf'
" fzf keymap
nnoremap <silent> ,f :FZF<cr>
nnoremap <silent> ,F :FZF ~<cr>

"----------[VIM-AIRLINE]----------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Airline diplays status of editor so don't need to showmode
" e.g. [-- INSERT --], [-- VISUAL --]
set noshowmode
set cmdheight=1
" use airline theme
let g:airline_theme='raven'
" use airline tabline extension : customized tab info
let g:airline#extensions#tabline#enabled = 1
" Only show file name
let g:airline#extensions#tabline#fnamemod = ':t'
"let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 1
" not show tab count
let g:airline#extensions#tabline#show_tab_count = 0
" show buffer number
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_splits = 1
"let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#tabline#buffers_label = 'b'

"----------[FILE EXPLORER]----------
Plug 'preservim/nerdtree'
" mapping not recursively F9 to NerdtreeToogle  all mode except for INSERT Mode
noremap <F9> <Esc>:NERDTreeToggle<CR>

" File Explorer With Icon
Plug 'ryanoasis/vim-devicons'

"----------[GIT INTEGRATION]----------
Plug 'tpope/vim-fugitive'
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gl :Gclog<CR>
" Show only current file's log
nnoremap <Leader>gll :Gclog %<CR>
nnoremap <Leader>gvd :Gvdiffsplit<CR>
nnoremap <Leader>gb :Git blame<CR>

" highlight changing
Plug 'airblade/vim-gitgutter'

"----------[LANGUAGE AUTO COMPLETE]----------
" NOTE : required clangd
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Auto complete bracket, quotes
Plug 'raimondi/delimitmate'

"----------[TAGBAR]----------
Plug 'majutsushi/tagbar'
" when toggle tagbar the focus will move to tagbar window
let g:tagbar_autofocus = 1
" mapping only normal mode F8 to TagbarToggle
nnoremap <F8> :TagbarToggle<CR>

"----------[CSCOPE]----------
" use cscope easily
"Plug 'ronakg/quickr-cscope.vim'
Plug 'brookhong/cscope.vim'
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>" s: Find this C symbol

" Easily insert a semicolon at the end of sentence
Plug 'lfilho/cosco.vim'
"autocmd FileType javascript,css,c,cpp nmap <silent> <Leader>; <Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css,c,cpp nmap <silent> ,; <Plug>(cosco-commaOrSemiColon)
autocmd FileType javascript,css,c,cpp imap <silent> <Leader>; <c-o><Plug>(cosco-commaOrSemiColon)

" Save file automatically
Plug '907th/vim-auto-save'
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification
let g:auto_save_events = ["InsertLeave", "CursorHold"]

" Commentate easily
Plug 'preservim/nerdcommenter'
filetype plugin on
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default

" Ripgrep integrate
"Plug 'jremmen/vim-ripgrep'
Plug 'mileszs/ack.vim'
source ~/.config/nvim/ack.vim

" --------------------[MATCHIT]
" extension of '%' command with XML, HTML, so on
Plug 'vim-scripts/matchit.zip'

call plug#end()

" ---------- Syntax
if has("syntax")
    syntax on
endif
filetype on

if has('termguicolors')
	set termguicolors
endif

set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1

"colorscheme badwolf

"colorscheme jellybeans
"let g:jellybeans_use_term_italics = 1
"colorscheme hybrid

"colorscheme sonokai
"let g:sonokai_style = 'andromeda'
"let g:sonokai_enable_italic = 1
"let g:sonokai_disable_italic_comment = 1

" Set Transparent if possible
hi Normal guibg=NONE ctermbg=NONE

" show line number
set number
set numberwidth=2
" tab size
set tabstop=4
set shiftwidth=4
" indent
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
map <F4> :bn<CR>
map <F3> :bp<CR>
map ,bd :bd<CR>
map ,bl :buffers<CR>

"save key map
" nnoremap <silent><c-s> :<c-u>update<cr>
" vnoremap <silent><c-s> <c-c>:update<cr>gv
" inoremap <silent><c-s> <c-o>:update<cr>

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
nnoremap ,ct :%s/\s\+$//e<CR>
" Toggle line number & white space formatting, GitGutter 	[,] -> [m]
nnoremap ,cm :set signcolumn=yes<CR>:set number list<CR>:GitGutterEnable<CR>
nnoremap ,cn :set signcolumn=no<CR>:set number! list!<CR>:GitGutterDisable<CR>
"----------C code auto formatting
" NOTE : asytle is required
" auto formatting like linux kernel coding
nnoremap ,ca :%!astyle --style=linux --pad-oper --pad-comma
			\ --indent-switches --indent=tab --attach-return-type
			\ --break-one-line-headers --align-pointer=name --align-reference=name<CR>
" TCC Style
nnoremap ,cs :%!astyle --style=bsd --indent=tab --indent-switches --pad-header --pad-oper --pad-comma --align-pointer=name<CR>
" nnoremap ,g :%!astyle --style=linux --indent-switches --pad-header --pad-oper --delete-empty-lines --indent=tab<CR>
" autocmd BufWritePre *.h,*.hpp,*.c,*.cpp :%!astyle --style=otbs --pad-oper --delete-empty-lines --indent=tab

" Compile & Run
" noremap <Ctrl><F5> !gcc -o hsomename % && ./somename
nnoremap ,<F5> :!gcc -Wall % && ./a.out <CR>
nnoremap ,<F6> :!gcc -Wall %<CR>
nnoremap ,<F7> :!gcc -Wall -g %<CR>
" map <F8> :w <CR> :!gcc % && ./a.out <CR>
" map <F8> :w <CR> :!gcc % -o %< && ./%< <CR>

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
