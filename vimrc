"-------------------------------
" vimrc
" gbh 20210723
" note: plugins are installed manually in ~/.vim/plugins/start

" sudo apt install ctags
" curl -Ss http://vim-php.com/phpctags/install/phpctags.phar > ~/.vim/phpctags
" chmod 755 ~/.vim/phpctags
" curl -L https://cs.symfony.com/download/php-cs-fixer-v2.phar -o ~/.vim/php-cs-fixer.phar
" chmod 755  ~/.vim/php-cs-fixer.phar
" git clone https://github.com/majutsushi/tagbar.git ~/.vim/pack/plugins/start/tagbar
" git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
" git clone https://github.com/NLKNguyen/papercolor-theme.git ~/.vim/pack/plugins/start/papercolor-theme
" git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/pack/plugins/start/vim-colors-solarized
" git clone https://github.com/reedes/vim-colors-pencil ~/.vim/pack/plugins/start/vim-colors-pencil
" git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/plugins/start/gruvbox 
" git clone https://github.com/gosukiwi/vim-atom-dark ~/.vim/pack/plugins/start/vim-atom-dark 
" git clone https://github.com/skielbasa/vim-material-monokai ~/.vim/pack/plugins/start/vim-material-monokai 
" git clone https://github.com/ludovicchabant/vim-gutentags.git ~/.vim/pack/plugins/start/vim-gutentags
" git clone --depth 1 https://github.com/dense-analysis/ale.git ~/.vim/pack/git-plugins/start/ale
" git clone https://github.com/stephpy/vim-php-cs-fixer.git ~/.vim/pack/plugins/start/vim-php-cs-fixer
" git clone https://github.com/frazrepo/vim-rainbow.git  ~/.vim/pack/plugins/start/vim-rainbow
" git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/pack/plugins/start/vim-gitgutter
" git clone https://github.com/vim-vdebug/vdebug.git ~/.vim/pack/plugins/start/vdebug
" git clone https://tpope.io/vim/fugitive.git ~/.vim/pack/plugins/start/tpope
" git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
" git clone --recursive https://github.com/andviro/flake8-vim.git ~/.vim/pack/plugins/start/flake8
" git clone git://github.com/neo4j-contrib/cypher-vim-syntax.git ~/.vim/pack/plugins/start/cypher-vim-syntax
" git clone https://github.com/voldikss/vim-floaterm.git ~/.vim/pack/plugins/start/vim-floaterm
" git clone https://github.com/junegunn/limelight.vim.git ~/.vim/pack/plugins/start/limelight

runtime! debian.vim

"-------------------------------
" standard setting
set nocompatible
set incsearch
set nu
set vb
set nowrap
set hlsearch
set binary noeol
set ts=4
set shiftwidth=4
"set paste
set laststatus=2
set mousehide
set backspace=indent,eol,start
set expandtab
set shell=/bin/bash " sometimes necessary if using fish

"-------------------------------
" increase copy buffer size (100 files, 500 lines, 200kb, hilite off)
set viminfo='100,<500,s200,h

"-------------------------------
" open file at the previous-viewed location
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


"-------------------------------
" load indentation rules
if has("autocmd")
  filetype plugin indent on
endif


"-------------------------------
" termguicolors
if (has("termguicolors"))
	set termguicolors
	set t_Co=256
endif


"-------------------------------
" set the backup dir
set backup
if !isdirectory($HOME."/.vim/backupdir")
    silent! execute "!mkdir ~/.vim/backupdir"
endif
set backupdir=~/.vim/backupdir
set noswapfile


"-------------------------------
" folding
" <SPACE>
set foldmethod=indent
set foldlevel=99
nnoremap <space> za


"-------------------------------
" maximize new window
if (has("gui_running"))
	set lines=999 columns=999
endif


"-------------------------------
" ale config
" ale is for realtime async linting
" NB: you need to install flake8 in your venv with `pip install flake8`
let g:ale_open_list = 0
let g:ale_lint_on_save = 'never' 
let g:ale_sign_error = '!>'
let g:ale_sign_warning = '?>'
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0  
"let b:ale_python_flake8_options = '--max-line-length=120 --ignore=E265,E266,501'

let g:ale_linters = {
\   'php': ['php'],
\   'python': ['flake8'],
\}

let g:flake8_ignore="C901"


"-------------------------------
" php-cs-fixer config
" <F4> fix
let g:php_cs_fixer_path = "~/.vim/php-cs-fixer.phar"
let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_php_path = "/usr/bin/php" 
map <F4> :call PhpCsFixerFixFile()<CR>


"-------------------------------
" colorscheme leader keys
nnoremap <leader>1 :colo PaperColor<CR> :syntax on<CR>
nnoremap <leader>2 :colo gruvbox<CR> :syntax on<CR>
nnoremap <leader>3 :colo pencil<CR> :syntax on<CR>
nnoremap <leader>4 :colo atom-dark<CR> :syntax on<CR>
nnoremap <leader>5 :colo solarized<CR> :syntax on<CR>


"-------------------------------
" colorscheme background toggle leader key
" \c to toggler light/dark bg
function! Bglight()
    echom "set bg=light"
    set bg=light
    set nolist
endfunction

function! Bgdark()
    echom "set bg=dark"
    set bg=dark
    set nolist
endfunction

function! ToggleBg()
  if &bg ==# "light"
    call Bgdark()
  else
    call Bglight()
  endif
endfunction

nnoremap <leader>c :call ToggleBg()<CR>


"-------------------------------
" 
nnoremap <leader>p :set syntax=php<CR>

"-------------------------------
" fontsize toggler
" F1    increment 2
" C-F1  decrement 2
function! ResizeFont(sizechangeamount)
    let fontregex = '^\(.* \)\([1-9][0-9]*\)$'
    let fontname = substitute(&guifont, fontregex, '\1', '')
    let currentsize = substitute(&guifont, fontregex, '\2', '')
    let newsize = currentsize + a:sizechangeamount 
    let &guifont = fontname . newsize
endfunction

function! IncrementFont()
    call ResizeFont(2)
endfunction

function! DecrementFont()
    call ResizeFont(-2)
endfunction

nnoremap <F1> :call IncrementFont()<CR>
nnoremap <C-F1> :call DecrementFont()<CR>


"-------------------------------
" tagbar config
" turn tag navigator on and off
nmap <C-F5> :TagbarToggle<CR>


"-------------------------------
" lightline config
" set lightline to show current function
let g:tagbar_phpctags_bin='~/.vim/phpctags'
let g:lightline = {
    \ 'active': {
    \   'left': [['mode'], ['gitbranch'], ['readonly', 'filename', 'modified'], ['tagbar']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'inactive': {
    \   'left': [['absolutepath']],
    \   'right': [['lineinfo'], ['filetype']]
    \ },
    \ 'component': {
    \   'lineinfo': '%l\%L [%p%%], %c, %n',
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \   'ale': '%{ale#statusline#Status()}',
    \   'gitbranch': '%{FugitiveStatusline()}',
    \   'gitbranch2': '%{fugitive#rev-parse --abbrev-ref HEAD}',
    \   'gutentags': '%{gutentags#statusline("[Generating...]")}'
    \ },
    \ }


"-------------------------------
" gutentags config
let g:gutentags_generate_on_write = 1
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png', '*.jpeg',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2', '*.tgz',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]


"-------------------------------
" limelight
" toggle limelight with \l
nnoremap <leader>l :Limelight!! <CR>

"-------------------------------
" move visual blocks up and down with J and K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

let g:floaterm_autoclose=2
let g:floaterm_autohide=2
let g:floaterm_shell="/usr/bin/fish"
let g:floaterm_keymap_new = '<Leader>t'

"-------------------------------
" set defaults
colo gruvbox
set guifont=Monospace\ 15
set bg=dark
filetype plugin on
if has("syntax")
  syntax on
endif

