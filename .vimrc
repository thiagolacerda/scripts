execute pathogen#infect()
execute pathogen#helptags()

" Set 256 colors
set t_Co=256

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Enable syntax highlight
syntax on

" Set color scheme
"colorscheme gardener

" Set folding
set foldmethod=syntax
set foldlevel=9999999

" Show matching brace
set showmatch

" Show white spaces and tabs
set list
set listchars=tab:»·,trail:·

" Highlight on searching a word
set hlsearch

" Incremental search
set incsearch

" Show current line
"set cursorline

" C identation style
set autoindent
set smartindent
set cindent

" Tab stop
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Do not create backups files
set nobackup

" Keep N lines of command line history
set history=50

" In many terminal emulators the mouse works just fine, thus enable it.
"set mouse=a

" Undoing N changes
set undolevels=1000

" Write swap file to disk after each 20 characters
set updatecount=100

" Write swap file to disk after 6 inactive seconds
set updatetime=6000

" Scroll off N lines
set scrolloff=4

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
    	\   exe "normal g`\"" |
    	\ endif

"set paste
set pastetoggle=<F11>
set ignorecase
"set background=light
set shell=bash
set statusline=File:\ %f\ %r%=\|\ Total\ lines:%L\ \|\ Row:%l\ \|\ Col:%c\ \|\ %p%%\ 
set laststatus=2
set formatoptions+=cro
	
map <F5> :set list! <enter>

au BufRead,BufNewFile *.qml set filetype=javascript
" Show right margin at column 80
" set colorcolumn=80
"
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

au! FileType python setl nosmartindent

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*/build/*,*.jpg,*.png,*.jpg,*.ttf,*.sfont,*.path,*.ico,*.svg,*.bmp,*.wav,*.xpm,*.ogg,*.snd,*.gif,*.jng,*.pdf,*.o,*.obj,*.exe,*.so,*.pem,*.props,*.filters,*.tiff,*.edc,*.po,*.sb,*.xib,*.JPG,*.GIF,*.class,*.vtt,*.mp4,*.mp3,*.dat,*.dtd,*.otf,*.mht,*.woff,*.webarchive,*.frag,*.vert,*.dll,*.lib,*.oga,*.jar,ChangeLog*,*.a,*.strings,*.t,*.pl,*.ogv,*.jpeg,*.aaf,*.gzip

let g:ctrlp_max_height = 50
let g:ctrlp_use_caching = 1
let g:ctrlp_max_files = 0
"let g:ctrlp_lazy_update = 1
let g:ctrlp_by_filename = 1

" command-t related
let g:CommandTMaxCachedDirectories=0
"let g:CommandTTagIncludeFilenames=1
let g:CommandTMaxDepth=60
let g:CommandTMaxFiles=1000000
let g:CommandTNeverShowDotFiles=1
let g:CommandTScanDotDirectories=1

"let g:ctrlp_max_height =
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 60
let g:ctrlp_by_filename = 1
let g:ctrlp_show_hidden = 0
"let g:ctrlp_lazy_update = 1
"let g:ctrlp_user_command ='find %s -type f | grep -P ".*\.c$|.*\.cpp$|.*\.h$|.*\.cmake$|.*\.txt$|.*\.js$|.*\.html$|.*\.xml$|.*\.idl$|.*\.py$|.*\.pm|.*\.css"'
