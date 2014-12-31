" =============================================================================
"  Initialization
" =============================================================================

" Vundle requirements
set nocompatible
filetype off

" Setup Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" My Plugins
Plugin 'scrooloose/syntastic'
Plugin 'rodjek/vim-puppet'
Plugin 'godlygeek/tabular'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" If vimrc has been modified, re-source it for fast modifications
autocmd! BufWritePost *vimrc source %

" =============================================================================
"  Filetype Association
" =============================================================================

au BufRead,BufNewFile *vimrc
\ set foldmethod=marker
augroup Puppet
    autocmd! BufEnter *.pp set filetype=puppet
augroup end
augroup RubySyntaxFiles " Ruby syntax
    autocmd! BufRead,BufEnter *.rb,*.rake set tabstop=2 sts=2 shiftwidth=2 filetype=ruby
    autocmd! BufEnter Rakefile set filetype=ruby
    autocmd! BufEnter Gemfile set filetype=ruby
    autocmd! BufEnter Vagrantfile set filetype=ruby
augroup end
augroup MarkdownFiles " Instead of this Modulo file bullshit
    autocmd! BufEnter *.md set filetype=markdown
augroup end
au BufRead,BufNewFile *_spec.rb
    \ nmap <F8> :!rspec --color %<CR>
augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter *.patch,*.rej,*.diff syntax enable
augroup end

" =============================================================================
"  Look and Feel
" =============================================================================

" Enable syntax highlighting
syntax enable

"Set colorscheme to Solarized
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"vim-airline options
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'

" Set to allow you to backspace while back past insert mode
set backspace=2

" Disable mouse
set mouse=

" Increase History
set history=100

" Enable relative number in the left column
"set relativenumber

"Enable line numbers
set number

" Give context to where the cursor is positioned in a file
set scrolloff=14

" Use UTF-8 encoding
set encoding=utf-8 nobomb

" Hide buffers after they are abandoned
set hidden

" Disable files that don't need to be created
set noswapfile
set nobackup
set nowritebackup

" Auto Complete Menu
set completeopt=longest,menu

" Show me a ruler
set ruler

" Tabbing and Spaces
" ------------------

" Use 4 spaces instead of tabs
set ts=4
set sts=4
set shiftwidth=4
set expandtab

" Auto indent
set autoindent
set smartindent

" Color Settings
" --------------

" Enable highlight search and highlight when searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set gdefault

" Highlight column 80
if exists('+colorcolumn')
    set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Highlight Trailing Whitespace
highlight ExtraWhitespace ctermbg=darkblue guibg=darkblue
match ExtraWhitespace /\s\+$/

" Persistent Undo
if v:version >= 703
    set undofile
    set undodir=~/.vim/tmp,~/.tmp,~/tmp,~/var/tmp,/tmp
endif

" Spelling / Typos
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q

" Open file and goto previous location
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
    \|     exe "normal! g`\""
    \|  endif