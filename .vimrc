syntax on
filetype plugin on
set nocompatible

set number
set ruler
set scrolloff=3
set autoindent
set cindent
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=2
set encoding=utf8
set fileencodings=utf8,latain,cp932
set mouse=a
set incsearch
set nowrapscan
set history=1000
set textwidth=0
set imdisable

if &term =~ "xterm-256color"
    set t_Co=256
endif

" Dein
" -------------------------------
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/dein'))
  call dein#begin(expand('~/.vim/dein'))

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('vim-scripts/L9')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('tpope/vim-surround')
  call dein#add('junegunn/vim-easy-align')

  call dein#add('tpope/vim-fugitive')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('kannokanno/previm')
  call dein#add('tyru/open-browser.vim')
  call dein#add('w0ng/vim-hybrid')
  call dein#add('jonathanfilip/vim-lucius')

  call dein#add('tpope/vim-obsession')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

let g:Align_xstrlen = 3

set list
set listchars=tab:^_

augroup MyAutoGroup
    autocmd!
augroup END

augroup highlightTab
  autocmd!
  autocmd Colorscheme * highlight Tab ctermfg=lightgray ctermbg=darkgray
  autocmd VimEnter,WinEnter * match Tab /\t/
augroup END

augroup highlightSuccessfull
  autocmd!
  autocmd Colorscheme * highlight Successfull ctermfg=red ctermbg=yellow
  autocmd VimEnter,WinEnter * match Successfull /successfull/
augroup END

augroup highlightWhitespaceEOL
  autocmd!
  autocmd Colorscheme * highlight WhitespaceEOL ctermbg=red
  autocmd VimEnter,WinEnter * 2match WhitespaceEOL /\s\+$/
augroup END

autocmd Colorscheme * highlight Pmenu ctermbg=17 ctermfg=39
autocmd Colorscheme * highlight PmenuSel ctermbg=26 ctermfg=159
autocmd Colorscheme * highlight PMenuSbar ctermbg=4

set background=dark
colorscheme lucius

match Tab /\t/
2match WhitespaceEOL /\s\+$/

autocmd FileType perl :set dictionary=/usr/share/vim/vim74/syntax/perl.vim
autocmd FileType perl :compiler perl
"let perl_fold=1
"set foldlevel=1
let php_folding=1

if !exists("autocommands_loaded")
let autocommands_loaded = 1
autocmd BufNewFile,BufRead *.cs set syntax=csharp
" setup folding
autocmd BufNewFile,BufRead *.cs set foldmethod=syntax
autocmd BufNewFile,BufRead *.md set foldmethod=syntax
endif

autocmd BufNewFile,BufRead *.tt set filetype=tt2html
autocmd BufNewFile,BufRead *.ep set filetype=epl
autocmd BufNewFile,BufRead *.tx set filetype=xslate

set hlsearch

set wrap
set linebreak
set showbreak=+\ 
if (v:version == 704 && has("patch338")) || v:version >= 705
    set breakindent
    set breakat=\ 
    autocmd MyAutoGroup BufEnter * set breakindentopt=min:20,shift:0
endif

" denite
" -------------------------------
nnoremap <silent> <C-f><C-f> :<C-u>Denite file_rec<CR>
nnoremap <silent> <C-f><C-i> :<C-u>Denite -input=<C-r>=expand('%:h')<CR> file_rec<CR>
nnoremap <silent> <C-f><C-m> :<C-u>Denite file_mru<CR>
nnoremap <silent> <C-f><C-g> :<C-u>Denite grep -buffer-name=search-buffer-denite<CR>
nnoremap <silent> <C-f><C-r> :<C-u>Denite -resume -buffer-name=search-buffer-denite<CR>
nnoremap <silent> <C-f><C-n> :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=+1 -immediately<CR>
nnoremap <silent> <C-f><C-p> :<C-u>Denite -resume -buffer-name=search-buffer-denite -select=-1 -immediately<CR>
"C-N,C-Pで上下移動
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
"C-J,C-Kでsplitで開く
call denite#custom#map('insert', '<C-j>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:do_action:vsplit>', 'noremap')
if executable('rg')
    call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
endif

" customize ignore globs
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy','matcher_ignore_globs'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [
      \ '.git/', 'build/', '__pycache__/',
      \ 'images/', '*.o', '*.make',
      \ '*.min.*',
      \ 'img/', 'fonts/', 'node_modules/'])

" statusline
" -------------------------------
set laststatus=2
highlight StatusLine   term=bold,reverse cterm=reverse ctermfg=28 ctermbg=226
highlight StatusLineNC term=reverse cterm=reverse ctermfg=18 ctermbg=250
"set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
set statusline=
set statusline+=%m    " %m 修正フラグ
set statusline+=%<    " 行が長すぎるときに切り詰める位置
set statusline+=[%n]  " バッファ番号
set statusline+=%r    " %r 読み込み専用フラグ
set statusline+=%h    " %h ヘルプバッファフラグ
set statusline+=%w    " %w プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
set statusline+=%y    " バッファ内のファイルのタイプ
set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
set statusline+=\     " 空白スペース1個
set statusline+=%1l   " 何行目にカーソルがあるか
"set statusline+=/
"set statusline+=%L    " バッファ内の総行数
set statusline+=,
set statusline+=%02c    " 何列目にカーソルがあるか
"set statusline+=%V    " 画面上の何列目にカーソルがあるか
set statusline+=\     " 空白スペース1個
set statusline+=%P    " ファイル内の何％の位置にあるか

" change statusline color while inserrt mode
" -------------------------------
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=57 ctermbg=178 cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

" for rapid statusline color clear
"inoremap <silent> <Esc> <ESC>

" change statusline color while inserrt mode
" -------------------------------
if has('multi_byte_ime')
    highlight Cursor guifg=NONE guibg=Green
    highlight CursorIM guifg=NONE guibg=Purple
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


"setlocal omnifunc=syntaxcomplete#Complete

" pulugin neocomplecache
" -------------------------------
" neocomplcache {{{
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Set manual completion length.
let g:neocomplete#manual_completion_start_length = 2
" Set minimum keyword length.
let g:neocomplete#min_keyword_length = 3

let g:neocomplete#enable_ignore_case = 0
"let g:neocomplete#lock_buffer_name_pattern = '\[fuf\]'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions',
      \ 'scala' : $DOTVIM.'/dict/scala.dict',
      \ 'ruby' : $DOTVIM.'/dict/ruby.dict'
      \ }

" Define include settings.
let perl_path = system("perl -e 'print join(\",\", @INC)'")
let g:neocomplete#sources#include#paths = { 'perl' : perl_path . ',lib' . ',t/lib' }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'

" }}}

" Rename command
" -------------------------------
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" perltidy
" -------------------------------
vmap ,ptv <Esc>:'<,'>! perltidy<CR>

" abbrev
" -------------------------------
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc
iabbrev ss my $self = shift;<Left><C-R>=Eatchar('\s')<CR>


" cursorline
" -------------------------------
set cursorline
highlight CursorLine term=underline cterm=underline
highlight CursorLine term=none cterm=none ctermfg=none ctermbg=88
"augroup vimrc-auto-cursorline
"  autocmd!
"  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
"  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
"  autocmd WinEnter * call s:auto_cursorline('WinEnter')
"  autocmd WinLeave * call s:auto_cursorline('WinLeave')
"
"  let s:cursorline_lock = 0
"  function! s:auto_cursorline(event)
"    if a:event ==# 'WinEnter'
"      setlocal cursorline
"      let s:cursorline_lock = 2
"    elseif a:event ==# 'WinLeave'
"      setlocal nocursorline
"    elseif a:event ==# 'CursorMoved'
"      if s:cursorline_lock
"        if 1 < s:cursorline_lock
"          let s:cursorline_lock = 1
"        else
"          setlocal nocursorline
"          let s:cursorline_lock = 0
"        endif
"      endif
"    elseif a:event ==# 'CursorHold'
"      setlocal cursorline
"      let s:cursorline_lock = 1
"    endif
"  endfunction
"augroup END

" markdown preview
" -------------------------------
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a "Google Chrome"'

" vim-easy-align
" -------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
