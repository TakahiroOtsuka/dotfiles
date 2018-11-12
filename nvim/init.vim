"set termguicolors

set number
set scrolloff=3
set cindent
set expandtab
set tabstop=4
set shiftwidth=4
set fileencodings=utf8,latain,cp932
set mouse=a
set nowrapscan

" Dein
" -------------------------------
if &compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END
augroup MyAutoGroup
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" タブの可視化
set list
set listchars=tab:^_

augroup highlightTab
  autocmd!
  autocmd Colorscheme * highlight Tab ctermfg=lightgray ctermbg=darkgray
  autocmd VimEnter,WinEnter * match Tab /\t/
augroup END

" typoを可視化
augroup highlightSuccessfull
  autocmd!
  autocmd Colorscheme * highlight Successfull ctermfg=red ctermbg=yellow
  autocmd VimEnter,WinEnter * match Successfull /successfull/
augroup END

" 行末スペースを可視化
augroup highlightWhitespaceEOL
  autocmd!
  autocmd Colorscheme * highlight WhitespaceEOL ctermbg=red
  autocmd VimEnter,WinEnter * 2match WhitespaceEOL /\s\+$/
augroup END

set wrap
set linebreak
set showbreak=+\ 
if (v:version == 704 && has("patch338")) || v:version >= 705
    set breakindent
    set breakat=\ 
    autocmd MyAutoGroup BufEnter * set breakindentopt=min:20,shift:0
endif

" key bind
" -------------------------------
nnoremap j gj
nnoremap k gk
"nnoremap <tab> gt
"nnoremap <s-tab> gT
nnoremap <c-g>n gt
nnoremap <c-g>p gT
nnoremap <c-g><c-n> gt
nnoremap <c-g><c-p> gT

inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap <> <><Left>

"nnoremap <CR> o<ESC>

" key bind for ref
nnoremap <C-r><C-a> :Ref alc <c-r>=expand('<cword>')<CR><CR>
nnoremap <C-r><C-p> :Ref perldoc <c-r>=expand('<cword>')<CR><CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz

inoremap <silent> jj <ESC>

" Rename command
" -------------------------------
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" cursorline
" -------------------------------
set cursorline
highlight CursorLine term=underline cterm=underline
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=88
