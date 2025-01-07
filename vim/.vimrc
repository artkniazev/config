" Vim language settings
" set langmenu=none
" language messages en

set nocompatible
set exrc
set secure

set termencoding=utf-8
set fileencoding=utf-8
set encoding=utf-8
menu Encoding.CP1251 :e ++enc=cp1251<CR>
menu Encoding.CP886 :e ++enc=cp866<CR>
menu Encodign.KOI8-U :e ++enc=koi8-u<CR>
map <F8> :emenu Encoding.<TAB>
set fileformats=unix,dos,mac
set fileencodings=utf-8,cp1251,cp866,koi8-r

set autoread " automatically refresh file when changed from outside
set nobackup
set noswapfile
set backupcopy=yes

set mouse=a

" Triger `autoread` when files changes on disk
" From https://unix.stackexchange.com/a/383044
"
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost * echo "File changed on disk. Buffer reloaded." | echohl None

" Custom filetypes
autocmd BufRead,BufNewFile *.eslintrc,*.prettierrc set filetype=javascript
" Beacus formatting is better
autocmd BufRead,BufNewFile *.json set filetype=javascript

set path+=**

" my specfific paths, obtained using echo '' | gcc -xc - -v -E
" set path+=/usr/local/include
" set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/9.0.0/include
" set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
" set path+=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/usr/include
" set path+="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk/System/Library/Frameworks (framework directory)"

set wildmenu
set wcm=<Tab>

"set foldmethod=expr foldexpr=getline(v:lnum)=~'^\s*'.&commentstring[0]

set wildmode=list:longest,full

set splitright " :vsplit opens to the right
set splitbelow " :split opens below                           

set laststatus=2
"set statusline=%f:%l/%L:%c%=%f%m%r%h%w\ %y\ [%2p%%] " too much

set ttyfast
set lz

" Persistent undo
" note: creates too many additional files!
"if has('persistent_undo')
"    set undofile
"endif
"set undolevels=10000

" Default text settings
set number " activate number column
set numberwidth=4 " number column is 4 chars wide
set nowrap " do not wrap long lines
set sidescroll=10 " scroll horizontally for 5 chars
set shiftwidth=4 " number of spaces for autoindet
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType json setlocal shiftwidth=2
autocmd FileType html setlocal shiftwidth=2
autocmd FileType css setlocal shiftwidth=2
autocmd FileType scss setlocal shiftwidth=2
autocmd FileType sass setlocal shiftwidth=2
autocmd FileType yaml setlocal shiftwidth=2
set shiftround " round indents to multiple of 'shiftwidth'
set tabstop=4 " number of spaces that <Tab> character in the file counts for
autocmd FileType javascript setlocal tabstop=2
autocmd FileType json setlocal tabstop=2
autocmd FileType html setlocal tabstop=2
autocmd FileType css setlocal tabstop=2
autocmd FileType scss setlocal tabstop=2
autocmd FileType sass setlocal tabstop=2
autocmd FileType yaml setlocal tabstop=2
set softtabstop=4 " number of space inserted when pressing <Tab>
autocmd FileType javascript setlocal softtabstop=2
autocmd FileType json setlocal softtabstop=2
autocmd FileType html setlocal softtabstop=2
autocmd FileType css setlocal softtabstop=2
autocmd FileType scss setlocal softtabstop=2
autocmd FileType sass setlocal softtabstop=2
autocmd FileType yaml setlocal softtabstop=2
set expandtab " Use the appropriate number of spaces to insert a <Tab>
set smarttab
set autoindent 
set cindent
set backspace=2 " make backspace work like in most other apps
set showmatch " briefly jump to the matching paren
set matchtime=3 " matching paren blink time
set hlsearch " highligh previous search result
set incsearch " incremental search
set ignorecase " ignore case when searching
set smartcase " ignore case only when typing all lowercase
set virtualedit=all " Allow to position cursor outside the line in all modes
set cursorline
"highlight CursorLine cterm=underline ctermbg=NONE
"highlight CursorColumn term=reverse ctermbg=DarkGray
highlight ColorColumn cterm=NONE ctermbg=Gray
autocmd FileType markdown setlocal colorcolumn=
set colorcolumn=81
syntax enable

" Wrapping options
set nowrap " No wrapping by default
set breakindent " When wrapping wrapped lines will have the same indent
autocmd FileType markdown setlocal wrap
set whichwrap+=<,>,h,l,[,] " allow left/right arrow, h/l, [/] to move between wrapped lines
set linebreak " But break only at characters at the breakat option
set textwidth=0 " Set default text width to non-wrapped
set wrapmargin=0 " Set wrap margin from the right to zero
set nolist " list disables linebreak
set formatoptions-=t " Prevent wrapping using textwidth option when formatting

" Autocomplete options
set completeopt=menuone,longest " autocomplete: menu even for one element, increment completition
set complete="" " autocomplete sources
set complete+=. " from current buffer
set complete+=k " from dictionary
set complete+=b " from other buffers
set complete+=t " from tags

"" Keybindings
" Easy mode switch (conflicts with russian input due to often ол
" inoremap jk <esc>
" Magic mode for all searches
nnoremap / /\v
" :nohl on Backspace
nmap <silent> <BS> :nohl<CR>

" PLUGINS
set nocp " 'compatible' is not set
filetype off
filetype plugin on " plugins are enabled
filetype plugin indent on

" Vim Explorer
noremap <F2> :Explore<CR>
noremap <F3> :Vexplore<CR>

"let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_list_hide='^\..*'

" Russian Keyboard Layout
" From https://habr.com/en/post/98393/
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
" Switch keyboard layout on C-F instead of C-^
cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>
nmap <silent> <C-F> <C-^>
vmap <silent> <C-F> <C-^>
" Switch keyboard layout on hj instead of C-^ (conflicts with ро)
" cmap <silent> hj <C-^>
" imap <silent> hj <C-^>
" nmap <silent> hj <C-^>
" vmap <silent> hj <C-^>

" Source .vimrc on change
autocmd! bufwritepost $VIM/.vimrc source $VIM/.vimrc
 
" Prettier
" nnoremap gp :silent %!prettier --stdin --stdin-filepath % --trailing-comma all --single-quote<CR>

" Pathogen
"execute pathogen#infect()
