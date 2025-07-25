nnoremap <up> <nop>
vnoremap <up> <nop>
nnoremap <down> <nop>
vnoremap <down> <nop>
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

" Shorten updatetime
set updatetime=100

" Turn syntax highlighting on.
syntax on
let g:markdown_fenced_languages = ['c', 'cpp', 'yaml', 'python', 'sh', 'bash', 'vim']
let g:c_syntax_for_h = 1
let g:java_ignore_javadoc = 1

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

" Enable line numbering
set nu
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

augroup nerdtree
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup end

" vim-commentary
augroup commentary
  autocmd!
  autocmd FileType c,cpp,yara,rascal setlocal commentstring=//\ %s
  autocmd FileType gas setlocal commentstring=#\ %s
  autocmd FileType laburnumscript setlocal commentstring=#\ %s
augroup end

" Enable spellcheck certain file types
augroup spellchecking
  autocmd!
  autocmd FileType markdown,tex,text,mail,gitcommit setlocal spell
augroup end

" Enable linewrapping for certain file types
augroup linewrapping
  autocmd!
  autocmd FileType markdown,tex,text setlocal tw=80
augroup end

" Set filetypes
augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.yar,*.yara setlocal filetype=yara
  autocmd BufNewFile,BufRead *.ih setlocal filetype=cpp
  autocmd BufNewFile,BufRead *.gas setlocal filetype=gas autoindent
  autocmd BufNewFile,BufRead *.rsc setlocal filetype=rascal
  autocmd BufNewFile,BufRead *.ls setlocal filetype=laburnumscript syntax=conf
augroup end

" Set paredit
let g:paredit_leader = '\'
augroup paredit_g
  autocmd!
  autocmd FileType laburnumscript call PareditInitBuffer()
augroup end

" Open help in man
runtime ftplugin/man.vim
augroup help_K
  autocmd!
  autocmd FileType c,cpp,bash,sh setlocal keywordprg=:Man
augroup end

" Set utf-8
set encoding=UTF-8

" Backspace things
set backspace=indent,eol,start

" Use system clipboard
set clipboard=unnamed
if executable("xsel")
  autocmd VimLeave * call system("xsel -ib", getreg('+'))
endif

" Show airline buffers
let g:airline#extensions#tabline#enabled = 1

" CoC
let g:coc_global_extensions = [
      \ '@yaegassy/coc-ansible',
      \ 'coc-clangd',
      \ 'coc-go',
      \ 'coc-jedi',
      \ 'coc-json',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-texlab',
      \ ]
let g:coc_filetype_map = {
      \ 'yaml.ansible': 'ansible',
      \ }

func s:SbAllowLoad(fileName)
  exe 'badd ' .. a:fileName
  exe 'sb ' .. a:fileName
endfunc

command! -nargs=+ SbAllowLoad call s:SbAllowLoad(<f-args>)
nnoremap <leader>g :call CocActionAsync('jumpDefinition', 'SbAllowLoad')<CR>
nnoremap <leader>r :call CocActionAsync('rename')<CR>
nnoremap <leader>u :call CocActionAsync('jumpUsed')<CR>
nnoremap <leader>i :call CocActionAsync('doHover')<CR>
nnoremap <leader>c :call CocActionAsync('codeAction')<CR>
nnoremap <leader>e <Plug>(coc-codeaction-cursor)

set switchbuf=useopen

" Enable highlighting of C++11 attributes
let g:cpp_attributes_highlight = 1

" Highlight struct/class member variables (affects both C and C++ files)
let g:cpp_member_highlight = 1

" Bind format to \f
nnoremap <leader>f :FormatCode<CR>

" Don't close buffers when switching
set hidden

" Start server for pdf
if has("clientserver") && empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
  if executable("sioyek")
    let g:vimtex_view_method = 'sioyek'
  elseif executable("okular")
    let g:vimtex_view_general_viewer = 'okular'
    let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
  endif
endif

let g:vimtex_fold_enabled = 1

augroup vimTex
  autocmd!
  autocmd FileType tex setlocal foldmethod=expr foldexpr=vimtex#fold#level(v:lnum)
augroup end

let g:vimtex_format_enabled = 1

" Termdebug
let g:termdebug_config = {
      \ 'wide': 1,
      \ 'disasm_window': 1,
      \ 'variables_window': 1,
      \ 'register_window': 1
      \ }


" ALE
let g:ale_virtualtext_cursor = 'all'
let g:ale_pattern_options = {
      \ 'Termdebug-asm-listing': {'ale_enabled': 0},
      \ }
let g:ale_linter_aliases = {
      \ 'gas': ['asm'],
      \ }
let g:ale_linters = {
      \ 'gas': ['gcc', 'llvm_mc'],
      \ 'python': ['flake8'],
      \ }

" Traces
let g:traces_preview_window = "winwidth('%') > 160 ? 'vnew' : '10new'"

" GPG
let g:GPGPreferSign = 1
let g:GPGDefaultRecipients = ['Laburnum']

" git
command! TabG tabnew | NERDTreeClose | G | only
let s:git_user = substitute(system("git config user.name"), '\n', '', '')
let s:git_email = substitute(system("git config user.email"), '\n', '', '')
let @g = "iSigned-off-by: " .. s:git_user .. " <" .. s:git_email .. ">"

" Maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" vimwiki
let g:vimwiki_list = [{
      \ 'path': '~/Documents/vimwiki',
      \ 'syntax': 'markdown',
      \ 'ext': 'md',
      \ 'diary_rel_path': 'journal',
      \ 'auto_diary_index': 1,
      \ 'auto_generate_links': 1,
      \ 'auto_tags': 1,
      \ 'auto_generate_tags': 1,
      \ }]
let g:vimwiki_global_ext = 0
let g:vimwiki_auto_header = 1
let s:vimwiki_path_stuff = g:vimwiki_list[0]['path'] .. "/" .. g:vimwiki_list[0]['diary_rel_path']

augroup vimwiki_
  autocmd!
  autocmd BufNewFile,BufRead ~/Documents/vimwiki/journal/**   exe 'setlocal dictionary+=' .. join(globpath(s:vimwiki_path_stuff, '*', 0, 1), ',')
augroup END

" calendar
let g:calendar_first_day = 'monday'
let g:calendar_google_calendar = 1
nnoremap <leader>cal :Calendar -view=day -position=topleft -split=vertical -width=27<CR>
nnoremap <leader>caL :Calendar -view=year -position=topright -split=horizontal -height=12<CR>

function! s:prefix_zero(num) abort
  if a:num < 10
    return '0'.a:num
  endif
  return a:num
endfunction

" Callback function for Calendar.vim
function! DiaryDay(day, month, year, week, dir, wnum) abort
  let day = s:prefix_zero(a:day)
  let month = s:prefix_zero(a:month)

  let link = a:year.'-'.month.'-'.day
  if winnr('#') == 0
    if a:dir ==? 'V'
      vsplit
    else
      split
    endif
  else
    wincmd p
    if !&hidden && &modified
      new
    endif
  endif

  call vimwiki#diary#make_note(a:wnum, 0, link)
endfunction

augroup calendar
  autocmd!
  autocmd FileType calendar nmap <buffer> <CR> :call DiaryDay(b:calendar.day().get_day(), b:calendar.day().get_month(), b:calendar.day().get_year(), b:calendar.day().week(), "V", v:count1)<CR>
augroup END

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
Plug 'airblade/vim-gitgutter'

Plug 'dyng/ctrlsf.vim'

Plug 'tpope/vim-surround'

Plug 'bfrg/vim-cpp-modern', { 'for': ['c', 'cpp'] }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tomasiser/vim-code-dark'

Plug 'ryanoasis/vim-devicons'

Plug 'dense-analysis/ale'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

Plug 'wesQ3/vim-windowswap'

Plug 'hashivim/vim-terraform'

Plug 'will133/vim-dirdiff'

Plug 'jamessan/vim-gnupg'

Plug 'Shirk/vim-gas'

Plug 'markonm/traces.vim'

Plug 'olistrik/vim-rascal-syntax'

Plug 'wellle/context.vim'

Plug 'vim-scripts/paredit.vim'

Plug 'vimwiki/vimwiki'
Plug 'itchyny/calendar.vim'
call plug#end()

" codefmt
call glaive#Install()
Glaive codefmt shfmt_options=`['-i', '8', '-ci', '-bn']`

" Colourscheme
colorscheme codedark
