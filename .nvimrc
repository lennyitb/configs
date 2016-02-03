" Leonard Henry Phelan IV

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

" source ~/.nvim/plug.vim

call plug#begin ('~/.nvim/bundle')

" Plugins!
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'thinca/vim-quickrun'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jplaut/vim-arduino-ino'
Plug 'wellle/targets.vim'
Plug 'nathanaelkane/vim-indent-guides'
" Plug 'vim-scripts/YankRing.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'vim-scripts/Wombat'
Plug 'mhinz/vim-startify'
" Plug 'Valloric/YouCompleteMe'
call plug#end ()

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
		AirlineTheme badwolf
		echo 'Theme changed: "PaperColor dark"'
	else
		" if g:themetogglevar==1
		" 	let g:themetogglevar=2
		" 	" Solarized light
		" 	set background=light
		" 	AirlineTheme solarized
		" 	colorscheme solarized
		" 	echo 'Theme changed: \"Solarized light"'
		" else
			if g:themetogglevar==2
				let g:themetogglevar=0
				" Papercolor light
				set background=light
				colorscheme PaperColor
				AirlineTheme PaperColor
				echo 'Theme changed: "Papercolor light"'
			endif
		" endif
	endif
endfunction

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

" Tab shortcuts
set showtabline=2
cabbr te tabedit
cabbr tn tabnew
cabbr tc tabclose
cabbr tm tabmove

cnoremap pi	PlugInstall

" You know what it does
" You know you love it
cabbr n normal
cabbr nn %normal

" Map Leader
let mapleader = ","
" Easy way into Normal Insert mode
inoremap ` <C-o>
" Switch windows easily with \\
" And do other stuff
nnoremap \	<C-w>
nnoremap \\	<C-w>w

" Retab a file with g=
function! Indent ()
	let winview = winsaveview ()
	execute 'normal! gg=G'
	call winrestview (winview)
endfunction

function! UnIndent ()
	let winview = winsaveview ()
	execute '%s/^\s\+//'
	call winrestview (winview)
endfunction

nnoremap g= :call Indent ()<CR>
nnoremap =g :call UnIndent ()<CR>

function! Trailing ()
	let winvie = winsaveview ()
	execute '%s/\s\+$//'
	call winrestview (winview)
endfunction

nnoremap <Leader>$ :call Trailing

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
let g:EasyMotion_keys = 'aoeuhtnsid1234567890'',.pyfgcrl;qjkxbmwvzh'
" Easymotion search smartcase
let g:EasyMotion_smartcase = 1

" Searching
set smartcase
" Highlight all results
set hlsearch
" Start searching before enter is pressed
set incsearch
set gdefault
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

" g\ to create a group
cnoremap g\ \(\)<Left><Left>

" " Better way to do what ^that^ does
" " Similar to more modern regex
" cnoremap (	\(
" cnoremap )	\)
" cnoremap (<BS>	(
" cnoremap )<BS>	)
" " Now with similar functionality for
" " word boundries
" cnoremap <	\<
" cnoremap >	\>
" cnoremap <<BS>	<
" cnoremap ><BS>	>
" " And range braces
" cnoremap {	\{
" cnoremap {<BS>	{

" g[ puts a space between function and args:
" 	abs(17); -> abs (17);
" g] opposite
nnoremap g[ :%s/\(\a\)\([<{(]\)/\1 \2<CR>
nnoremap g] :%s/\(\a\)\s*\([(<{]\)/\1\2/<CR>:noh<CR>

" Quickly press ht to exit to normal mode
" Better suited to Dvorak keyboards
inoremap ht <Esc>
vnoremap ht <Esc>

" Page up and page down made easy
nnoremap L <C-f>
nnoremap H <C-b>
nnoremap gj <C-f>
nnoremap gk <C-b>

" ^ goes to the first non-whitespace character
" It's way more useful than 0, which is easier to type
" I flip'd them
nnoremap 0 ^
nnoremap ^ 0

" I dare you to press <F9>
nnoremap <F9> :!eject<CR><CR>
" More prankster shtuff
" nnoremap w ggdG
" nnoremap w :!eject<CR><CR>

" What does gq do anyway?
" Yes, I sometimes use ex
nnoremap gq gQ
" This gets you into command mode without the need to dance on the shift key
nnoremap q; q:
