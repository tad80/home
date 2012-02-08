" Default configuration file for Vim
" Written by Aron Griffis <agriffis@gentoo.org>
" Modified by Ryan Phillips <rphillips@gentoo.org>
" Added Redhat's vimrc info by Seemant Kulleen <seemant@gentoo.org>

" The following are some sensible defaults for Vim for most users.
" We attempt to change as little as possible from Vim's defaults,
" deviating only where it makes sense
set nocompatible        " Use Vim defaults (much better!)
set bs=2                " Allow backspacing over everything in insert mode
set ai                  " Always set auto-indenting on
"set backup             " Keep a backup file
set viminfo='20,\"500   " read/write a .viminfo file -- limit regs to 500 lines
set history=50          " keep 50 lines of command history
set ruler               " Show the cursor position all the time

" Added to default to high security within Gentoo. Fixes bug #14088
set modelines=0

if v:lang =~ "^ko"
  set fileencodings=euc-kr
  set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~ "^ja_JP"
  set fileencodings=utf-8
  set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~ "^zh_TW"
  set fileencodings=big5
  set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~ "^zh_CN"
  set fileencodings=gb2312
  set guifontset=*-r-*
endif
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
  set fileencodings=utf-8,latin1
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
  set t_RV=          " don't check terminal version
  set t_Co=8
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
endif

if has('vim_starting')"{{{
" Load settings for each location.
"  function! s:vimrc_local(loc)
"    let files = findfile('vimrc_local.vim', escape(a:loc, ' '), -1)
"    for i in reverse(filter(files, 'filereadable(v:val)'))
"      source `=i`
"    endfor
"  endfunction

  filetype off

"  call s:vimrc_local(getcwd())

" Load neobundle.
  if &runtimepath !~ '/neobundle.vim'
    execute 'set runtimepath+=' . expand('~/.bundle/neobundle.vim')
  endif

" Load bundles.
"  call pathogen#runtime_append_all_bundles()
" call vundle#rc(expand('~/.bundle'))
  call neobundle#rc(expand('~/.bundle'))

  filetype plugin on
  filetype indent on
endif

if has("autocmd")
augroup gentoo
  au!

  " Gentoo-specific settings for ebuilds.  These are the federally-mandated
  " required tab settings.  See the following for more information:
  " http://www.gentoo.org/doc/en/xml/gentoo-howto.xml
  au BufRead,BufNewFile *.e{build,class} let is_bash=1|set ft=sh
  au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab

  " In text files, limit the width of text to 78 characters, but be careful
  " that we don't override the user's setting.
  autocmd BufNewFile,BufRead *.txt if &tw == 0 | set tw=78 | endif

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif
augroup END
endif " has("autocmd")

"-------------KotaENV--------------
"set foldmethod=indent
set history=10000
set showcmd
set nocompatible
set incsearch
set backspace=indent,eol,start
set hidden
set list
set listchars=eol:<,tab:>-
set formatoptions=q
set ttyfast
set wildchar=<TAB>
set laststatus=2
set cmdheight=1
set backspace=2
set wildmenu
set wildmode=full
set smartcase
set nostartofline
set tabstop=4
set shiftwidth=4
set softtabstop=4
set viminfo='1000,f1,\"5000,h,c
set cpo-=<
set wcm=<C-Z>
map <C-M> :emenu <C-Z>
set ignorecase
set smartcase
set wrapscan
set ruler
set softtabstop=0
set hlsearch
set nrformats=
set more
set ttyfast

"-------------ENCODE--------------
set fileformat=unix
set fileformats=unix,dos,mac
set fileencoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp,utf-8,ucs-2le,ucs-2,cp932,euc-jp
set termencoding=utf-8
set encoding=japan

"-------------RCS--------------
nmap <C-I>I :write %<CR>:! ci -u %<CR>:edit!<CR>
nmap <C-I>O :! co -l %<CR>:edit!<CR>
nmap <C-I>D :write %<CR>:! rcsdiff -u % \| less -r<CR>
nmap <C-I>L :! rlog % \| less -r<CR>

"-------------KEYMAP--------------
nmap <C-C><C-N>			:new<CR>
nmap <C-C><C-V>			:call Indent()<CR>
nmap <C-B><C-P>			:bp<CR>
nmap <C-B><C-N>			:bn<CR>
nmap <C-B><C-D>			:bd<CR>
nmap <C-B><C-L>			:ls<CR>
nmap <C-E>f					:write %<CR>:! ./%<CR>
nmap <C-C><C-G>			yE:%s:<C-R>0::g<LEFT><LEFT>
nmap <C-C><C-R>			yw:%s:<C-R>0::g<LEFT><LEFT>
nmap <C-C><C-L>			:dis<CR>
nmap <C-C><C-M>			:map<CR>

"-------------SP--------------
nmap <C-W>s					:vsp<CR>
nmap <C-W>S					:sp<CR>
nmap <C-W><C-e>				:vsp<CR>:wincmd w<CR>:edit! ./<CR>
nmap <C-W>E					:sp<CR>:wincmd w<CR>:edit! ./<CR>
nmap <C-W><C-A>				:all<CR>

"-------------MAIL--------------
nmap MS					:write %<CR>:! nkf % \| mailsubj %

"-------------AUTO--------------
autocmd BufRead *.php :set dictionary=~/.vim/dictionary/php.dict
autocmd BufRead *.ctp :set dictionary=~/.vim/dictionary/php.dict
autocmd BufRead /etc/apache2/* :set filetype=apache

"-------------STABAR--------------
set statusline=%n:\%{hostname()}@%<%F\ %m%r%h%w[%{&fileformat}][%{has('multi_byte')&&\ &fileencoding!=''?&fileencoding:&encoding}]%y%=[%4.4B,%3.3c][%5.5l/%5.5L]\ %3.3p%%

"-------------FUNC--------------
function Indent()
	if &ai == '1'" && &list =='1'
		set noai
		set nolist
	else
		set ai
		set list
	endif
endfunction

"-------------MENU--------------
menu File.Encode.Sjis	:set fileencoding=cp932<CR>
menu File.Encode.Euc		:set fileencoding=euc-jp<CR>
menu File.Format.Unix	:set fileformat=unix<CR>
menu File.Format.Dos		:set fileformat=dos<CR>
menu File.Format.Mac		:set fileformat=mac<CR>
menu File.Global.No		:%!awk '{print NR, $0}'<CR>
menu File.Global.Space	:set expandtab<CR>:retab<CR>
menu File.Global.Delete	:g/^$/d<CR>

menu Explolr.Vsprit		:vsp<CR>:wincmd w<CR>:edit! ./<CR>
menu Explolr.Sprit		:sp<CR>:wincmd w<CR>:edit! ./<CR>

menu Vim.Session.Make	:mksession! %.vim<CR>
menu Vim.Session.Load	:source %.vim<CR>
menu Vim.Mark.show		\mt
menu Vim.Mark.Hidden		\mh
menu Vim.Mark.Clear		\ma
menu Vim.RegisterList	:dis<CR>
menu Vim.BuffurList		:ls<CR>
menu Vim.HistoryList		:his<CR>

menu Copy.Serch.Show		[I
menu Copy.Serch.Top		[i
menu Copy.Serch.Junp		[<tab>
menu Copy.IPMess			:! tipmsg -e vi -s 
menu Copy.PIPMess			:.w ! tipmsg -e -s 
menu Copy.Paste			:call Indent()<CR>
menu Copy.Replace			:%s/
menu Copy.Delete			yE:%v:<C-R>0

menu Cvs.Commit			:write<CR>:!cvs commit %<CR>:edit!<CR>
menu Cvs.checkout			:!cvs checkout %<CR>:edit!<CR>
menu Cvs.Add				:write<CR>:!cvs add %<CR>
menu Cvs.Log				:!cvs rlog % \| less -r<CR>
menu Cvs.Diff				:write %<CR>:! cvs diff % \| less -r<CR>

menu Rcs.Checkin			:write %<CR>:! ci -u %<CR>:edit!<CR>
menu Rcs.Checkout			:write %<CR>:! co -l %<CR>:edit!<CR>
menu Rcs.Unlock			:write %<CR>:! rcs -l %<CR>:edit!<CR>
menu Rcs.Diff				:write %<CR>:! rcsdiff -u % \| less -r<CR>
menu Rcs.Rlog				:write %<CR>:! rlog % \| less -r<CR>

menu Mail.Send				:write %<CR>:! nkf % \| mailsubj %

"-------------CODE--------------
menu Perl.For				:r ~/.vim/perl/for<CR>
menu Perl.While			:r ~/.vim/perl/while<CR>
menu Perl.Fireach			:r ~/.vim/perl/foreach<CR>
menu Perl.Open				:r ~/.vim/perl/open<CR>
menu Perl.Out				:r ~/.vim/perl/out<CR>
menu Perl.Txt2regex		:! ~/.vim/txt2regex-0.7/txt2regex-0.7.sh<CR>

"-------------PLUGIN--------------
menu Vim.Plugin.Outlinemode	:call FoldDigest()<CR>
menu Vim.Plugin.Tag				:Tlist<CR>
menu Vim.Plugin.Tagexp			:TagExplorer<CR>
menu Vim.Plugin.GpgCrypt		:gpg -c %<CR>
menu Vim.Plugin.GpgEdit			:GPGEditRecipients<CR>
menu Vim.Plugin.GpgShow			:GPGViewRecipients<CR>

"-------------PGINCF--------------

let showmarks_enable=0
"set backup
"set backupdir=~/.vim/savevers
"set patchmode=.clean
"let savevers_types = "*"
"let savevers_dirs = &backupdir
let versdiff_no_resize=1
nmap <silent> <F5> :VersDiff -<CR>
nmap <silent> <F6> :VersDiff +<CR>
nmap <silent> <F8> :VersDiff -c<CR>
let folddigest_options="vertical"
let folddigest_size="35"

nmap <silent> <F9> :call FoldDigest()<CR>
nmap <silent> <F10> :Tlist<CR>
set tags=tags


filetype plugin on
filetype indent on

"------------neobundle-----------
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/mattn/zencoding-vim.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'


"------------neocomplcache-----------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_manual_completion_start_length = 0
let g:neocomplcache_caching_percent_in_statusline = 1
let g:neocomplcache_enable_skip_completion = 1
let g:neocomplcache_skip_input_time = '0.5'


"------------unite-----------
"let g:unite_enable_start_insert=1
"nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"nnoremap <silent> ,uf :<C-u>Unite file<CR>
"nnoremap <silent> ,ufb :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
"nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
"nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

"------------vim-ref-----------
let g:ref_phpmanual_path = $HOME . '/.vim/phpmanual/php-chunked-xhtml'

