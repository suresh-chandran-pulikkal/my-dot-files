" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

set nocompatible              " be iMproved, required
filetype on                  " required

" NeoVim plugin manager
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
"Plug 'ncm2/ncm2'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'ycm-core/YouCompleteMe' " Autocompletion plugin
" Plug 'koalaman/shellcheck' " shellcheck  to fix and lint Shell scripts #Not required anymore, it already included in ALE
Plug 'dense-analysis/ale' " Asynchronous lint engine
call plug#end()

" Vundle plugin manager
" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim

"scall vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" Plugin 'oblitum/youcompleteme'
"PPlugin 'ycm-core/YouCompleteMe'
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
"Pcall vundle#end()            " required
" filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

if &compatible
  set nocompatible               " Be iMproved
endif

" Pathogen plugin manager
" set nocp
"execute pathogen#infect()
" syntax on
"filetype plugin indent on

" Required:
" set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
" call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
" NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle 'valloric/youcompleteme'
"NeoBundle 'drewtempelmeyer/palenight.vim'
"NeoBundle 'morhetz/gruvbox'
"NeoBundle 'junegunn/fzf'
"NeoBundle 'preservim/nerdtree'
"NeoBundle 'vim-airline/vim-airline'
"NeoBundle 'vim-airline/vim-airline-themes'
" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

"call neobundle#end()

" Required:
"filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
" NeoBundleCheck


 " To ignore plugin indent changes, instead use:
 "filetype plugin on
 "
 " Brief help
 " :PluginList       - lists configured plugins
 " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
 " :PluginSearch foo - searches for foo; append `!` to refresh local cache
 " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
 "
 " see :h vundle for more details or wiki for FAQ
 " Put your non-Plugin stuff after this line

" Type :so % to refresh .vimrc after making changes

" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible
" Leader - ( Spacebar )
let mapleader = " "

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete command
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoread      " Reload files changed outside vim
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

"Set default font in mac vim and gvim
set guifont=Inconsolata\ for\ Powerline:h24
set cursorline    " highlight the current line
set cursorcolumn  " higlight cursor with a long vertical line
 hi CursorLine cterm=NONE ctermbg=NONE ctermfg=blue
set visualbell    " stop that ANNOYING beeping
set wildmenu
set wildmode=list:longest,full

"Allow usage of mouse in iTerm
set ttyfast
"set mouse=a
" set ttymouse=xterm2

" Make searching better
" set gdefault      " Never have to type /g at the end of search / replace again
set ignorecase    " case insensitive searching (unless specified)
set smartcase
set hlsearch
nnoremap <silent> <leader>, :noh<cr> " Stop highlight after searching
set incsearch
set showmatch

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·
" Make it obvious where 100 characters is
" set textwidth=100
" set formatoptions=cq
"set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=0

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
" set splitbelow
set splitright

" Auto resize Vim splits to active split
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999

"HTML Editing
set matchpairs+=<:>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" ================ Scrolling ========================

set scrolloff=19         "Start scrolling when we're 19 lines away from margins
set sidescrolloff=15
set sidescroll=1

"Toggle relative numbering, and set to absolute on loss of focus or insert mode
set rnu
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction
function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()

"Use enter to create new lines w/o entering insert mode
" nnoremap <CR> o<Esc>
"Below is to fix issues with the ABOVE mappings in quickfix window
" autocmd CmdwinEnter * nnoremap <CR> <CR>
" autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" <c-h> is interpreted as <bs> in neovim
"
" This is a bandaid fix until the team decides how
"
" they want to handle fixing it...(https://github.com/neovim/neovim/issues/2048)
nnoremap <silent> <bs> :TmuxNavigateLeft<cr>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Always use vertical diffs
set diffopt+=vertical

" Switch syntax highlighting on, when the terminal has colors
let g:solarized_termcolors=256
set t_Co=256
syntax enable
set background=dark
" colorscheme atom

" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Load up all plugins
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"
" display only differences in vimdiff
" set diffopt=filler,context:0



""" MORE AWESOME HOTKEYS
" Run the q macro
nnoremap <leader>q @q

" bind H to toggle cursor highlighting
:nnoremap H :set cursorline! cursorcolumn!<CR>

"Map Ctrl + S to save in any mode
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" Also map leader + s
map <leader>s <C-S>

" Quickly close windows
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q!<cr>

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" AUTOCOMMANDS - Do stuff

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

"update dir to current file
autocmd BufEnter * silent! cd %:p:h
autocmd BufEnter * highlight Normal guibg=#1c1c1c



augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " autocmd BufRead *.jsx set ft=jsx.html
  " autocmd BufNewFile *.jsx set ft=jsx.html

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 100 characters for Markdown
  " autocmd BufRead,BufNewFile *.md setlocal textwidth=100

  " Automatically wrap at 100 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=100
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass,less setlocal iskeyword+=-
augroup END


" TODO: Don't think I need this anymore? Pretty sure supertab handles it
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
" function! InsertTabWrapper()
"     let col = col('.') - 1
"     if !col || getline('.')[col - 1] !~ '\k'
"         return "\<tab>"
"     else
"         return "\<c-p>"
"     endif
" endfunction
"
"
" Only do this part when compiled with support for autocommands
"
 if has("autocmd")
   augroup redhat
    autocmd!
" In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78
" When editing a file, always jump to the last cursor position
 autocmd BufReadPost *
 \ if line("'\"") > 0 && line ("'\"") <= line("$") |
 \   exe "normal! g'\"" |
 \ endif
 " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
 autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp

" start with RPM spec file template
autocmd BufNewFile *.spec 0r ~/.vim/vimfiles/template.spec
autocmd BufNewFile *.spec $-2r !date '+* \%a \%b \%e \%Y Suresh Chandran <sureshc775@gmail.com> 0-1'
autocmd BufNewFile *.spec 1
autocmd BufNewFile *.spec /^Name:/
autocmd BufNewFile *.spec nohl
autocmd BufNewFile *.spec :put =expand('%:r')
autocmd BufNewFile *.spec normal! kJ0
autocmd BufNewFile,BufRead *.spec :map! <F12> <C-R>=strftime('* %a %b %e %Y Suresh Chandran <sureshc775@gmail.com> ')<CR>
augroup END
endif

" start python file with a template
autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py

" start shell script with a template
autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh
" set file encoding
set encoding=utf-8
" Use shell script linters
let b:ale_linters = { 'sh': ['language_server'],}
let b:ale_fixers = { 'sh' : ['shfmt','shellcheck']}
" Use python fixers and linters on ALE
let p:ale_linters = {'python' : ['flake8','bandit','pydocstyle','mypy']}
let p:ale_fixers = {
      \ '*': ['remove_trailing_lines','trim_whitespace'],
      \ 'python' : ['black','isort']
      \ }

" Use ansible YAML/JSON fixer and linter on ALE
let y:ale_linters = {'yaml' : ['spectral','yaml-language-server','swaglint','actionlint','circleci']}
let y:ale_fixers = {
      \ 'yaml' : ['prettier','yamlfix']
      \ }

" Use git fixer and linter on ALE
let git:ale_linters = {'git' : ['actionlint']}
let g:ale_fix_on_save =1

