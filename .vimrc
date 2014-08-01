" Include the system settings
:if filereadable( "/etc/vimrc" )
source /etc/vimrc
:endif

" Include Arista-specific settings
:if filereadable( $VIM . "/vimfiles/arista.vim" )
source $VIM/vimfiles/arista.vim
:endif

" Put your own customizations below

if v:progname =~? "evim"
   finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
   set nobackup		" do not keep a backup file, use versions instead
else
   set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
   set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
   syntax on
   set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

   " Enable file type detection.
   " Use the default filetype settings, so that mail gets 'tw' set to 72,
   " 'cindent' is on in C files, etc.
   " Also load indent files, to automatically do language-dependent indenting.
   filetype plugin indent on

   " Put these in an autocmd group, so that we can delete them easily.
   augroup vimrcEx
      au!

      " For all text files set 'textwidth' to 78 characters.
      autocmd FileType text setlocal textwidth=78

      " When editing a file, always jump to the last known cursor position.
      " Don't do it when the position is invalid or when inside an event handler
      " (happens when dropping a file on gvim).
      " Also don't do it when the mark is in the first line, that is the default
      " position when opening a file.
      autocmd BufReadPost *
               \ if line("'\"") > 1 && line("'\"") <= line("$") |
               \   exe "normal! g`\"" |
               \ endif

   augroup END

else

   set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
   command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis
endif

" ###
" ### Begin of actually useful modifications for me.
" ###

" Changing the tabsize.
set expandtab
set tabstop=3
set shiftwidth=3
set softtabstop=3
set shiftwidth=3

" Background and other display features.
set background=dark
"set number
set pastetoggle=<F2>
set showmode
filetype indent plugin on

" Map uppercase W and W to lowercase to avoid annoying typo errors.
map :W :w
map :Q :q
map :WQ :wq
map :Wq :wq

"set ignorecase
set title
set showmode
set ttyfast
set wildchar=<TAB>
set wildmode=list,longest,full

"set guifont=Droid\ Sans\ Mono\ 9
set guifont=Ubuntu\ Mono\ 11
set t_Co=256

set nobackup
set nowritebackup 

set autochdir

" Change the tab labels. Maybe not working right now?
set guitablabel=%t

" Indent guide plugin configurations.
"let g:indent_guides_start_level = 2
"let g:indent_guides_guide_size = 1

" Allow Gvim to select tabs by pressing Alt + (0 - 9)
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> 10gt

" Move tabs with alt + left|right
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" Same as above, but for Mac OSX.
" http://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim
nnoremap <silent> [1;9D :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> [1;9C :execute 'silent! tabmove ' . tabpagenr()<CR>

" Previous/next tabs with alt + ,|.
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" Additional plugin keybindings.
nnoremap <F2> :set invpaste paste?<CR>
"map <F3> :echo "You're editing " bufname("%")<CR>
nnoremap <F3> :Tagbar<CR>
nnoremap <F4> :NERDTree<CR>
nnoremap <F5> :tabedit .<CR>
nnoremap <F6> :SignatureList <CR>
nnoremap <F7> :set mouse=a <CR>
nnoremap <F8> :set invnumber <CR>
nnoremap <F9> :MBEToggle<CR>

" Map jj to the escape key in INSERT and VISUAL MODE.
" Better and easier to use in the long run.
imap jj <Esc>
vmap jj <Esc>

" Tabbing and space indicators.
let g:indentLine_color_term = 239
let g:indentLine_char = '|'

" Required for the Powerline plugin to show up properly.
set laststatus=2
"set encoding=utf-8

" Bufferline configuration.
let g:bufferline_echo = 1
let g:bufferline_show_bufnr = 1
let g:bufferline_rotate = 1

" Airline configuration.
let g:airline_theme = "powerlineish"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2

let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#bufferline#overwrite_variables = 0

" Fixing compatibility with tmux using 256 color.
set t_ut=

"Disable cscope error messages.
set nocscopeverbose

" Set visual effect to show 85 column limit.
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
"augroup vimrc_autocmds
"autocmd BufEnter * highlight OverLength ctermbg=darkred guibg=#592929
"autocmd BufEnter * match OverLength /\%86v.*/
"augroup END

" Add a colored column at 85.
" http://scriptogr.am/joshearl/post/adding-a-vertical-ruler-to-vim
augroup vimrc_autocmds
   set colorcolumn=85
   highlight ColorColumn guibg=Gray14 ctermbg=235
augroup END

" Better ctags key bindings.
map <A-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Do not auto indent labels in C and C++.
set cinoptions+=L0

" Mapping leader key and functions.
let mapleader = ","

" Buffer control mapping.
map . :b 

" Mapping of buffer control keys.
" http://stackoverflow.com/questions/5559029/quickly-switching-buffers-in-vim-normal-mode
noremap <leader>n :bn<cr>
noremap <leader>p :bp<cr>
noremap <leader>d :bd<cr>

" Mapping of Arista internal code navigation tools.
noremap <leader>s :AGid<cr><cr>
noremap <leader>w :AGid -D<cr><cr>
noremap <leader>a :AGid 

" Mapping for CtrlP omni search tool.
noremap <C-b> :CtrlPBuffer<cr>

" Make AGid Fold color match that of molokai.
let AGid_Hi_Fold = "ctermfg=67  ctermbg=16"
let AGid_Hi_FoldColumn = "ctermfg=67  ctermbg=16"

" Tagbar configurations.
let g:tagbar_left = 1

" Solarized config.
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
"let g:solarized_termcolors=256

" Molokai config.
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai

" Automatically remove trailing white space for various filetypes.
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.tin :%s/\s\+$//e

" Synastic configurations.
let g:syntastic_mode_map = { "mode": "passive" }
let g:syntastic_check_on_wq = 0
noremap <leader>y :SyntasticCheck<cr>
noremap <leader>u :SyntasticReset<cr>

" Signature and mark configurations.
noremap <leader>m :marks<cr>
