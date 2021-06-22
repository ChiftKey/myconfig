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
"Plug 'nanotech/jellybeans.vim'
"Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'ghifarit53/tokyonight-vim'
" various languages enhanced syntax
Plug 'sheerun/vim-polyglot'
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
Plug 'wesleyche/SrcExpl' " exploring the source code definition
" Git Interaction
Plug 'tpope/vim-fugitive'
" highlight changing
Plug 'airblade/vim-gitgutter'
" Language auto complete
" NOTE : required clangd
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Auto complete bracket, quotes
Plug 'raimondi/delimitmate'

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

" ---------- Color Scheme
set background=dark
"colorscheme jellybeans
colorscheme gruvbox
"let g:tokyonight_style = 'storm' " available: night, storm
"let g:tokyonight_enable_italic = 1
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
" Toggle line number & white space formatting, GitGutter 	[,] -> [m]
nnoremap ,m :set number! list!<CR>:GitGutterToggle<CR>
"----------C code auto formatting
" NOTE : asytle is required
" auto formatting like linux kernel coding
nnoremap ,f :%!astyle --style=linux --pad-header --pad-oper --indent-switches --indent=tab 
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
" Give more space for displaying messages.
set cmdheight=2
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>""

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
							\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction
