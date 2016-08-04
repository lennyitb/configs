" Leonard Henry Phelan IV

" """""""""""""""""""""""""""""""""
" Plugins
" """""""""""""""""""""""""""""""""
call plug#begin ('~/.nvim/bundle')
" Enhanced Navigation
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'maxbrunsfeld/vim-yankstack'
" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
" External Interface
Plug 'jplaut/vim-arduino-ino'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-startify'
call plug#end ()
cnoremap pi	PlugInstall

" """""""""""""""""""""""""""""""""
" Airline
" """""""""""""""""""""""""""""""""
set encoding=utf-8
let g:airline_symbols = {}
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Not complain about mixed indent with multiline comments
let g:airline#extensions#whitespace#mixed_indent_algo = 1


" """""""""""""""""""""""""""""""""
" Colors & Themes
" """""""""""""""""""""""""""""""""
set t_Co=256
syntax on
" Papercolor color scheme
set background=light
colorscheme PaperColor
let g:airline_theme='PaperColor'

" Switch theme with <F2>
nnoremap <F2> :call Themetoggle ()<cr>
let g:themetogglevar=0
function! Themetoggle ()
	if g:themetogglevar==0
		let g:themetogglevar=2
		" PaperColor dark
		set background=dark
		colorscheme PaperColor
		" AirlineTheme badwolf
		AirlineTheme dark
		echo 'Theme changed: "PaperColor dark"'
	else
		if g:themetogglevar==2
			let g:themetogglevar=0
			" Papercolor light
			set background=light
			colorscheme PaperColor
			AirlineTheme PaperColor
			echo 'Theme changed: "Papercolor light"'
		endif
	endif
endfunction

" """""""""""""""""""""""""""""""""
" Numbering & Indentation
" """""""""""""""""""""""""""""""""
" <-Those things on the side
set numberwidth=5

" Relative + Absolute numbers in normal mode,
" Just absolute in Insert mode.
set number
set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Use the SUPIRIOR indent style
set autoindent
set noexpandtab
set tabstop=8
set shiftwidth=8

" Retab a file with g=
function! Indent ()
	let winview = winsaveview ()
	execute 'normal! gg=G'
	call winrestview (winview)
endfunction
nnoremap g= :call Indent ()<CR>

" """""""""""""""""""""""""""""""""
" Tabs & Windows
" """""""""""""""""""""""""""""""""
" Tab shortcuts
set showtabline=2
cabbr te tabedit
cabbr tn tabnew
cabbr tc tabclose
cabbr tm tabmove

" Switch windows easily with \\
" And do other stuff
nnoremap \	<C-w>
nnoremap \\	<C-w>w


" """""""""""""""""""""""""""""""""
" Navigation
" """""""""""""""""""""""""""""""""
" Map Leader
let mapleader = ","
" Easy way into Normal Insert mode
inoremap ` <C-o>

" Eliminate trailing whitespace
function! Trailing ()
	let winvie = winsaveview ()
	execute '%s/\s\+$//'
	call winrestview (winview)
endfunction
nnoremap <Leader>a :call Trailing

" J-> Join lines!, K->Split lines!
nnoremap K i <cr><esc>^mwgk:silent! s/\v +$//<cr>:noh <cr>j0

" u-> undo, U-> redo
nnoremap U <C-r>

" qq makes a macro, Q plays it
nnoremap Q @q

" Easy way into ex-mode
nnoremap <space> :

" Set easymotion leader to "-"
map - <Plug>(easymotion-prefix)
" Easymotion letter order coresponds to QWERTY
let g:EasyMotion_keys = 'aoeuhtnsid1234567890'',.pyfgcrl;qjkxbmwvz'
" Easymotion search smartcase
let g:EasyMotion_smartcase = 1

" """""""""""""""""""""""""""""""""
" Searching
" """""""""""""""""""""""""""""""""
" Searching
set smartcase
" Highlight all results
set hlsearch
" Start searching before enter is pressed
set incsearch
" Don't wrap, make fstab readable
set nowrap
" Why would I ever replace something on just one line?
nnoremap // :noh <cr>
" Type // to turn off highlighting after a search
cnoremap ss %s/

" Asthetic stuff
" leave 7 lines when scrolling
set so=7
" Show partially completed normal command in the corner
set showcmd

" Recognise *.ino files as C code
au BufRead,BufNewFile *.ino set filetype=c

" Yankstack shtuff
" Cycle through yankstack with parens
" They do weird stuff in normal mode anyway
let g:yankstack_map_keys = 0
nmap ( <Plug>yankstack_substitute_older_paste
nmap ) <Plug>yankstack_substitute_newer_paste
" Press Y( to open yankstack window
nnoremap Y) :reg<CR>
nnoremap Y( :Yanks<CR>


" Quickly press ht to exit to normal mode
" Better suited to Dvorak keyboards
inoremap ht <Esc>
vnoremap ht <Esc>

" Page up and page down made easy
nnoremap L <C-f>
nnoremap H <C-b>
nnoremap gj <C-f>
nnoremap gk <C-b>

" Swap 0 and ^
" ^ is much more useful, but difficult to reach
nnoremap 0 ^
nnoremap ^ 0

" """""""""""""""""""""""""""""""""
" Ex Commands & Ex Mode + S&R
" """""""""""""""""""""""""""""""""
" g\ to create a group
cnoremap g\ \(\)<Left><Left>
" Don't require /g at the end of every S&R
set gdefault
" Execute normal commands from ex prompt
cabbr n normal
cabbr nn %normal
" What does gq do anyway?
" Yes, I sometimes use ex
nnoremap gq gQ
" This gets you into command mode without the need to dance on the shift key
nnoremap q; q:
