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

" NeoBundle
" -------------------------------

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundle 'thinca/vim-ref'
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'Shougo/neocomplcache.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'jonathanfilip/vim-lucius'

"NeoBundle 'nosami/Omnisharp'
NeoBundleLazy 'nosami/Omnisharp', {
\   'autoload': {'filetypes': ['cs']},
\   'build': {
\     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\   }
\ }


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


"autocmd FileType tt2html :set tabstop=2
"autocmd FileType tt2html :set shiftwidth=2

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

autocmd FileType perl :set dictionary=/usr/share/vim/vim71/syntax/perl.vim
autocmd FileType perl :compiler perl
"let perl_fold=1
"set foldlevel=1

if !exists("autocommands_loaded")
let autocommands_loaded = 1
autocmd BufNewFile,BufRead *.cs set syntax=csharp
" setup folding
autocmd BufNewFile,BufRead *.cs set foldmethod=syntax
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
map j gj
map k gk
"nnoremap <tab> gt
"nnoremap <s-tab> gT
"map <c-g>n gt
"map <c-g>p gT

imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>

"nnoremap <CR> o<ESC>

" key bind for ref
nnoremap <C-r><C-a> :Ref alc <c-r>=expand('<cword>')<CR><CR>
nnoremap <C-r><C-p> :Ref perldoc <c-r>=expand('<cword>')<CR><CR>

nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

inoremap <silent> jj <ESC>


"setlocal omnifunc=syntaxcomplete#Complete

"" pulugin fuf
"" -------------------------------
let g:fuf_modesDisable = []
let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png|meta)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|(^|/)blib/|^tmp/'
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$|(^|/)blib/'
let g:fuf_mrufile_maxItem = 10000
let g:fuf_enumeratingLimit = 40
let g:fuf_keyPreview = '<C-]>'
let g:fuf_previewHeight = 0

"nnoremap <silent> <C-n>      :FufBuffer<CR>
nnoremap <silent> <C-f><C-f>  :FufFile **/<CR>
nnoremap <silent> <C-f><C-i>  :FufFileWithCurrentBufferDir<CR>
"nnoremap <silent> <C-i>      :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nnoremap <silent> <C-f><C-j>  :FufMruFile<CR>
nnoremap <silent> <C-f><C-k>  :FufMruCmd<CR>
"nnoremap <silent> <C-p>      :FuzzyFinderDir <C-r>=expand('%:p:~')[:-1-len(expand('%:p:~:t'))]<CR><CR>
"nnoremap <silent> <C-f><C-d> :FuzzyFinderDir<CR>
"nnoremap <silent> <C-f><C-f> :FuzzyFinderFavFile<CR>
"nnoremap <silent> <C-f><C-t> :FuzzyFinderTag!<CR>
"nnoremap <silent> <C-f><C-g> :FuzzyFinderTaggedFile<CR>
"noremap  <silent> g]         :FuzzyFinderTag! <C-r>=expand('<cword>')<CR><CR>
"nnoremap <silent> <C-f>F     :FuzzyFinderAddFavFile<CR>
"nnoremap <silent> <C-f><C-e> :FuzzyFinderEditInfo<CR>
nnoremap <silent> <C-f><C-l>  :FufRenewCache<CR>

" pulugin neocomplecache
" -------------------------------
" neocomplcache {{{
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
"let g:NeoComplCache_EnableCamelCaseCompletion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
" Set manual completion length.
let g:neocomplcache_manual_completion_start_length = 2
" Set minimum keyword length.
let g:neocomplcache_min_keyword_length = 3

let g:neocomplcache_max_menu_width = 50

let g:neocomplcache_enable_ignore_case = 0
let g:neocomplcache_lock_buffer_name_pattern = '\[fuf\]'

" Print caching percent in statusline.
"let g:NeoComplCache_CachingPercentInStatusline = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions',
      \ 'scala' : $DOTVIM.'/dict/scala.dict',
      \ 'ruby' : $DOTVIM.'/dict/ruby.dict'
      \ }

" Define include settings.
let perl_path = system("perl -e 'print join(\",\", @INC)'")
let g:neocomplcache_include_paths = { 'perl' : perl_path . ',lib' . ',t/lib' }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

let g:neocomplcache_snippets_dir = $HOME.'/snippets'

" Plugin key-mappings.
imap <silent><C-k>     <Plug>(neocomplcache_snippets_expand)
smap <silent><C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
inoremap <expr><silent><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'

" }}}

" OmniSharp
" -------------------------------
"let g:OmniSharp_host = "http://localhost:2000"
"let g:OmniSharp_typeLookupInPreview = 1
"set noshowmatch
"nnoremap <space>ogd :OmniSharpGotoDefinition<cr>
"nnoremap <space>orn :OmniSharpRename<cr>
"nnoremap <space>ofu :OmniSharpFindUsages<cr>
"nnoremap <space>oss :OmniSharpStartServer<cr>

" syntastic
" -------------------------------
"let g:syntastic_perl_lib_path = "/home/otsuka/work/dragoon/lib"

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
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" markdown preview
" -------------------------------
au BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a "Google Chrome"'
