nnoremap <up> <nop>
vnoremap <up> <nop>
inoremap <up> <nop>
nnoremap <down> <nop>
vnoremap <down> <nop>
inoremap <down> <nop>
nnoremap <left> <nop>
vnoremap <left> <nop>
inoremap <left> <nop>
nnoremap <right> <nop>
vnoremap <right> <nop>
inoremap <right> <nop>

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Enable line numbering
set nu

" Turn syntax highlighting on.
syntax on

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Use space characters instead of tabs.
set expandtab

" Show command in the bottom
set showcmd

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Set folding method
set foldmethod=indent

" Don't start folding immediately
set nofoldenable

" Enable ruler
set ruler

" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

augroup nerdtree
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
  autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup end

" vim-commentary
augroup commentary
  autocmd!
  autocmd FileType c,cpp,yara setlocal commentstring=//\ %s
augroup end

" Enable spellcheck and linewrapping for certain file types
augroup spellchecking
  autocmd!
  autocmd FileType markdown,tex,text setlocal spell tw=79
augroup end

" Set filetypes
augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara
  autocmd BufNewFile,BufRead *.ih setlocal filetype=cpp
augroup end

" Set utf-8
set encoding=UTF-8

" Backspace things
set backspace=indent,eol,start

" Use system clipboard
set clipboard=unnamed

" Show airline buffers
let g:airline#extensions#tabline#enabled = 1

let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <leader>g :YcmCompleter GoTo<CR>
let g:ycm_confirm_extra_conf = 0

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Bind format to \f
nnoremap <leader>f :YcmCompleter Format<CR>

" Bind refactor to \r
nnoremap <leader>r :execute 'YcmCompleter RefactorRename' input( 'Rename to: ' )<CR>

" Don't close buffers when switching
set hidden

" Start server for pdf
if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

" vim --remote-silent +%l %f
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

let g:vimtex_fold_enabled = 1

augroup vimTex
  autocmd!
  autocmd FileType tex setlocal foldmethod=expr foldexpr=vimtex#fold#level(v:lnum)
augroup end

let g:vimtex_format_enabled = 1

autocmd BufWritePost *.py call flake8#Flake8()
let g:flake8_show_in_gutter = 1

call plug#begin()
Plug 'scrooloose/nerdtree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-sleuth'

Plug 'rhysd/vim-clang-format'

Plug 's3rvac/vim-syntax-yara'

Plug 'lervag/vimtex'

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-fugitive'

Plug 'dyng/ctrlsf.vim'

Plug 'tpope/vim-surround'

Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cpp'] }

Plug 'valloric/youcompleteme', { 'do': './install.py --all' }

Plug 'nvie/vim-flake8'

Plug 'tomasiser/vim-code-dark'

Plug 'ryanoasis/vim-devicons'
call plug#end()

" Colourscheme
colorscheme codedark
