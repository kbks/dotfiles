" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" Set color scheme!¬
"colorscheme codeschool
set clipboard=unnamed
set wildmenu
set wildmode=list:longest,full


" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
"set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=" "
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
        set undodir=~/.vim/undo
endif


" Start scrolling 7 lines before edge
set so=7

" Horizontal split always to the bottom
set splitbelow

" Puts vertical windows to right, instead of left.
set splitright

" Tabs are 4 chars wide
set tabstop=4

" Indentation size is 4 characters
set shiftwidth=4

" Make backspace work like most other apps
set backspace=2

" Dont add additional space on S-j
set nojoinspaces

" Convert tabs to spaces
set expandtab
set smarttab

" Be single lined
set nowrap


set visualbell                  "No sounds
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Enable line numbers
set number

set laststatus=2
"filetype off

call pathogen#helptags()
call pathogen#infect()
filetype plugin indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete


let g:airline#extensions#tabline#enabled = 1

" Mapping ctrl+arrow to tab switch
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

set showcmd

" Who doesn't like autoindent?
set autoindent

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Don't redraw when not needed
set lazyredraw

" Highlighting trail spaces
highlight ExtraWhitespace ctermfg=red guifg=red
" ctermfg=white guifg=white
match ExtraWhitespace /\s\+$/

" Displaying spaces as dots and EOL as ¬
set listchars=tab:▸\ ,trail:♥
set list!

let mapleader = " "

set t_Co=256
colorscheme bubblegum-256-dark

set autoindent
set smartindent
set smarttab
set expandtab

filetype plugin on
filetype indent on

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#use_vimproc = 0

" }}}
" Vim-go {{{
" =========
"
let g:go_disable_autoinstall = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }}}
" Syntastic {{{
" =========
"
" let g:syntastic_check_on_wq = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_javascript_checkers = ['eslint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '✖'
let g:syntastic_style_error_symbol = '☠'
let g:syntastic_warning_symbol = '☸'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn
" }}}
" Vim-airline {{{
let g:airline_section_y = '%{strftime("%D %T")}'
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme="bubblegum"
set encoding=utf-8


let g:gitgutter_avoid_cmd_prompt_on_windows = 0

""
"let g:airline_symbols = {}
"let g:airline_left_sep = ""
"let g:airline_left_alt_sep = ""
"let g:airline_right_sep = ""
"let g:airline_right_alt_sep = ""
"l"et g:airline_symbols.branch = ""
"let g:airline_symbols.readonly = ""
"let g:airline_symbols.linenr = ""
let g:airline_powerline_fonts = 1
let g:airline_symbols = {}
let g:airline_left_sep = ">"
let g:airline_left_alt_sep = ">"
let g:airline_right_sep = "<"
let g:airline_right_alt_sep = "<"
let g:airline_symbols.branch = "Ч"
let g:airline_symbols.readonly = "RO"
let g:airline_symbols.linenr = "👌"

" Commenting blocks of code.
nnoremap <leader>c gcc

" Remove trailing spaces on F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Folding {{{
" =======
"
set foldenable
set foldlevelstart=10
set foldmethod=indent
" Adding new folding method:
" au FileType javascript call JavaScriptFold()

" }}}


"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


nnoremap <silent> <C-K> <C-W>k
nnoremap <silent> <C-J> <C-W>j
nnoremap <silent> <C-H> <C-W>h
nnoremap <silent> <C-L> <C-W>l

" Horizontal split always to the bottom
set splitbelow

" Puts vertical windows to right, instead of left.
set splitright

" Tabs are 4 chars wide
set tabstop=4

" Indentation size is 4 characters
set shiftwidth=4

" Make backspace work like most other apps
set backspace=2


nnoremap <leader>f :NERDTreeToggle<CR>
" Explore (NERDTree) {{{
" ==============
"
" let g:netrw_list_hide= '^\..*'
" let g:netrw_hide = 1
" let g:netrw_liststyle = 3
" let g:netrw_keepdir = 0
autocmd StdinReadPre * let s:std_in=1
" NERDTree open if VIM's empty
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" let g:NERDTreeDirArrowExpandable = ' '
" let g:NERDTreeDirArrowCollapsible = ' '
let g:NERDTreeCopyCmd= 'cp -r'
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'white', 'none', '#FF896A', '#151515')
call NERDTreeHighlightFile('md', 'white', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'white', 'none', '#FF896A', '#151515')
call NERDTreeHighlightFile('config', 'white', 'none', '#FF896A', '#151515')
call NERDTreeHighlightFile('conf', 'white', 'none', '#FF896A', '#151515')
call NERDTreeHighlightFile('html', 'cyan', 'none', '#FF896A', '#151515')

call NERDTreeHighlightFile('styl', 'cyan', 'none', '#00C4FF', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', '#00C4FF', '#151515')
call NERDTreeHighlightFile('scss', 'cyan', 'none', '#00C4FF', '#151515')
call NERDTreeHighlightFile('sass', 'cyan', 'none', '#00C4FF', '#151515')

call NERDTreeHighlightFile('coffee', 'Red', 'none', '#FF896A', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#FF896A', '#151515')
call NERDTreeHighlightFile('json', 'Red', 'none', '#FF896A', '#151515')

call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
set fillchars+=vert:\|